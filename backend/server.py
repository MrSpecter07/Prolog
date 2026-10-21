import json
import os
import subprocess
from http.server import HTTPServer, SimpleHTTPRequestHandler
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
FRONTEND = ROOT / "frontend"
PROLOG_FILE = ROOT / "ALMACEN.pl"
PORT = int(os.environ.get("PORT", "8000"))


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(FRONTEND), **kwargs)

    def send_json(self, status, payload):
        content = json.dumps(payload, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def do_GET(self):
        if self.path == "/api/health":
            self.send_json(200, {"status": "ok", "service": "almacen"})
            return
        super().do_GET()

    def do_POST(self):
        if self.path != "/api/consultar":
            self.send_json(404, {"status": "error", "message": "Ruta no encontrada"})
            return

        try:
            length = int(self.headers.get("Content-Length", "0"))
            body = json.loads(self.rfile.read(length))
            product_id = body.get("id")
            if isinstance(product_id, bool) or not isinstance(product_id, int):
                raise ValueError("El ID debe ser un entero")
            if product_id < 1 or product_id > 20:
                raise ValueError("El ID debe estar entre 1 y 20")
        except (ValueError, TypeError, json.JSONDecodeError) as error:
            self.send_json(400, {"status": "error", "message": str(error)})
            return

        query = f"consultar_producto({product_id}),halt."
        try:
            result = subprocess.run(
                ["swipl", "-q", "-s", str(PROLOG_FILE), "-g", query],
                capture_output=True,
                text=True,
                timeout=10,
                check=False,
            )
        except FileNotFoundError:
            self.send_json(503, {"status": "error", "message": "SWI-Prolog no esta instalado"})
            return
        except subprocess.TimeoutExpired:
            self.send_json(504, {"status": "error", "message": "La consulta excedio el tiempo limite"})
            return

        if result.returncode != 0:
            self.send_json(502, {"status": "error", "message": result.stderr.strip()})
            return

        try:
            response = json.loads(result.stdout.strip().splitlines()[-1])
        except (IndexError, json.JSONDecodeError):
            self.send_json(502, {"status": "error", "message": "Prolog devolvio una respuesta invalida"})
            return

        self.send_json(200, response)


if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Servidor disponible en http://localhost:{PORT}")
    server.serve_forever()