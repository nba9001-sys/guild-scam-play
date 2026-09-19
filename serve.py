# -*- coding: utf-8 -*-
"""本機試玩網頁版用的小伺服器。

    python serve.py            （預設 http://localhost:8123）

⚠️ 不能直接雙擊 index.html：瀏覽器對 file:// 的頁面禁止載入 .wasm 與 .pck，
   你只會看到一片黑，而且不會有任何錯誤訊息。網頁遊戲一定要有伺服器。
"""
import http.server, os, socketserver, sys, webbrowser
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8123
os.chdir(os.path.dirname(os.path.abspath(__file__)))
class Handler(http.server.SimpleHTTPRequestHandler):
    extensions_map = dict(http.server.SimpleHTTPRequestHandler.extensions_map)
    extensions_map.update({".wasm": "application/wasm",
                           ".pck": "application/octet-stream",
                           ".js": "text/javascript"})
    def log_message(self, *a):
        pass
socketserver.TCPServer.allow_reuse_address = True
url = "http://localhost:%d/index.html" % PORT
print("Server: %s" % url)
print("First load downloads ~100 MB. Ctrl+C to stop.")
try:
    webbrowser.open(url)
except Exception:
    pass
with socketserver.TCPServer(("127.0.0.1", PORT), Handler) as httpd:
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nstopped.")
