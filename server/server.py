from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import urlparse, json
import threading
import sys
import random

lock = threading.Lock()
post_lock = threading.Lock()
players_connected = 0
MAX_PLAYERS = 4
gameIdCalculated = False
gameRunning = False
nextGameId = 0
playerIdGen = 0
totalGames = 5
livesPerGame = 4
PLAYERS_NOT_COUNTED = 0
lives =  [livesPerGame,  livesPerGame,
          livesPerGame,  livesPerGame]
GAME_ORDER = [x for x in range(totalGames)]
random.shuffle(GAME_ORDER)

def reset_state():
    global players_connected 
    global gameIdCalculated 
    global gameRunning 
    global nextGameId 
    global playerIdGen 
    global livesPerGame 
    global lives 
    global PLAYERS_NOT_COUNTED
    players_connected = 0
    gameIdCalculated = False
    gameRunning = False
    nextGameId = 0
    playerIdGen = 0
    livesPerGame = 4
    lives =  [livesPerGame,  livesPerGame,
              livesPerGame,  livesPerGame]
    PLAYERS_NOT_COUNTED = 0

def next_id():
    global playerIdGen
    global MAX_PLAYERS
    localId = playerIdGen
    playerIdGen = (playerIdGen + 1) % MAX_PLAYERS
    return localId

def next_game():
    global nextGameId
    global games
    nextGameId = (nextGameId + 1) % totalGames


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global players_connected
        global MAX_PLAYERS
        global gameIdCalculated
        global nextGameId
        global GAME_ORDER
        global lives
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        if (self.path == "/reset"):
            reset_state()
            return

        lives = [livesPerGame,  livesPerGame,
                 livesPerGame,  livesPerGame]
        lock.acquire()
        if players_connected == MAX_PLAYERS:
            players_connected = 0

        players_connected = players_connected + 1
        currentPlayerId = next_id()
        if not gameIdCalculated:
            next_game()
            gameIdCalculated = True
        lock.release()
        while(players_connected < MAX_PLAYERS):
            pass

        gameIdCalculated = False

        json = "{{\"player_id\": {0}, \"game_id\": {1}}}".format(currentPlayerId, GAME_ORDER[nextGameId])
        #json = "{{\"player_id\": {0}, \"game_id\": {1}}}".format(currentPlayerId, 0)
        print "returning from get: " + json

        self.wfile.write(json);
        return

    # game logic
    def do_POST(self):
        global gameIdCalculated
        global lives
        global post_lock
        global players_connected
        global GAME_ORDER
        global PLAYERS_NOT_COUNTED
        content_len = int(self.headers.getheader('content-length'))
        post_body = self.rfile.read(content_len)
        self.send_response(200)
        self.end_headers()

        data = json.loads(post_body)

        post_lock.acquire()
        print "players connected = " + str(players_connected)
        if players_connected + PLAYERS_NOT_COUNTED >= MAX_PLAYERS:
            players_connected = 0
        if not gameIdCalculated:
            next_game()
            gameIdCalculated = True
        player_id = int(data['player_id'])
        if data['player_won'] == False:
            lives[player_id] -= 1
        players_connected += 1
        post_lock.release()
        players_lost = [x for x in lives if x <= 0]
        print "players lost size " + str(len(players_lost))

        while(players_connected + PLAYERS_NOT_COUNTED < MAX_PLAYERS):
            pass
        PLAYERS_NOT_COUNTED = len(players_lost)
        gameIdCalculated = False

        has_this_player_lost = lives[player_id] <= 0
        other_active_players = [(k,v) for k,v in enumerate(lives) if k !=
                player_id and v > 0]
        print "other_active: " + str(other_active_players)
        
        msg = json.dumps({'game_id': GAME_ORDER[nextGameId],
            'lives': lives,
            'winrar': (not has_this_player_lost) and len(other_active_players) == 0
            })
        print "returning from post " + msg
        self.wfile.write(msg)
        return

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """arst """

if __name__ == '__main__':
    server = ThreadedHTTPServer(('0.0.0.0', int(sys.argv[1])), Handler)
    print 'Starting server on javierrizzo.com:' + sys.argv[1]
    server.serve_forever()
