from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import urlparse, json
import threading
players_connected = 0
lock = threading.Lock()
MAX_PLAYERS = 2

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global players_connected
        global MAX_PLAYERS 
        self.send_response(200)
        print "recibi peticion " + str(players_connected)
        self.end_headers()
        lock.acquire()
        players_connected = players_connected + 1
        lock.release()
        while(players_connected < MAX_PLAYERS):
            pass
        self.wfile.write("hola");
        return

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """arst """

if __name__ == '__main__':
    server = ThreadedHTTPServer(('localhost', 8080), Handler)
    print 'Starting server'
    server.serve_forever()
