from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
import os
import json

app = FastAPI()


@app.get("/server")
def server_list():
    """Logs a value to the log file for a given experiment"""
    try:
        server_list = json.loads(os.getenv("SERVER_LIST"))

    except Exception:
        server_list = ["http://localhost:8000"]
    return server_list


app.mount("/", StaticFiles(directory="../ui/dist", html=True))
