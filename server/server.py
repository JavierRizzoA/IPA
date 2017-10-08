from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import urlparse, json
import threading
import sys
import random

lock = threading.Lock()
post_lock = threading.Lock()
players_connected_get = 0
players_connected_post = 0
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
    global players_connected_get 
    global players_connected_post 
    global gameIdCalculated 
    global gameRunning 
    global nextGameId 
    global playerIdGen 
    global livesPerGame 
    global lives 
    players_connected_get = 0
    players_connected_post = 0
    global PLAYERS_NOT_COUNTED
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
        global players_connected_get
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
        MAX_PLAYERS = 4
        lock.acquire()
        if players_connected_get == MAX_PLAYERS:
            players_connected_get = 0
        players_connected_get = players_connected_get + 1
        currentPlayerId = next_id()
        if not gameIdCalculated:
            next_game()
            gameIdCalculated = True
        lock.release()
        while(players_connected_get < MAX_PLAYERS):
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
        global players_connected_post
        global GAME_ORDER
        global PLAYERS_NOT_COUNTED
        global MAX_PLAYERS
        content_len = int(self.headers.getheader('content-length'))
        post_body = self.rfile.read(content_len)
        self.send_response(200)
        self.end_headers()

        data = json.loads(post_body)
        print "got post request: " + post_body

        post_lock.acquire()
        print "players connected = " + str(players_connected_post)
        if not gameIdCalculated:
            next_game()
            gameIdCalculated = True
            players_connected_post = 0
        player_id = int(data['player_id'])
        if data['player_won'] == False:
            lives[player_id] -= 1
        if lives[player_id] > 0:
            players_connected_post += 1
        else:
            MAX_PLAYERS -= 1
        players_lost = [x for x in lives if x <= 0]
        post_lock.release()
        print "players lost size " + str(len(players_lost))

        while(players_connected_post < MAX_PLAYERS):
            pass
        PLAYERS_NOT_COUNTED = len(players_lost)
        gameIdCalculated = False

        has_this_player_lost = lives[player_id] <= 0
        other_active_players = [(k,v) for k,v in enumerate(lives) if k !=
                player_id and v > 0]
        print "other_active: " + str(other_active_players)
        
        m = {'game_id': GAME_ORDER[nextGameId],
            'lives': lives}
        if (not has_this_player_lost) and len(other_active_players) == 0:
            m['won'] = True
        msg = json.dumps(m)
        print "returning from post " + msg
        self.wfile.write(msg)
        return

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """arst """

if __name__ == '__main__':
    server = ThreadedHTTPServer(('0.0.0.0', int(sys.argv[1])), Handler)
    print 'Starting server on javierrizzo.com:' + sys.argv[1]
    server.serve_forever()
