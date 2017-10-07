from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import urlparse, json
import threading
import sys

players_connected = 0
lock = threading.Lock()
MAX_PLAYERS = 2
games = [True, True, True, True]
ids = ['Azul', 'Rojo', 'Verde', 'Amarillo']
gameIdCalculated = False
gameRunning = False
nextGameId = 0;
playerIdGen = 0;

def next_id():
    global playerIdGen
    global MAX_PLAYERS
    localId = playerIdGen
    playerIdGen = (playerIdGen + 1) % MAX_PLAYERS
    return localId

def next_game():
    global nextGameId
    global games
    nextGameId = (nextGameId + 1) % len(games)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global players_connected
        global MAX_PLAYERS
        global gameIdCalculated
        global nextGameId
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        print "recibi peticion " + str(players_connected)
        self.end_headers()
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

        json = "{{\"player_id\": {0}, \"game_id\": {1}}}".format(currentPlayerId, nextGameId)
        print json

        self.wfile.write(json);
        return

    def do_POST():
        global game_running
        


class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """arst """

if __name__ == '__main__':
    server = ThreadedHTTPServer(('192.168.6.172', int(sys.argv[1])), Handler)
    print 'Starting server on 192.168.2.172:' + sys.argv[1]
    server.serve_forever()
