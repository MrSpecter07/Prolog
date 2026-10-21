FROM swipl:stable

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 \
    && rm -rf /var/lib/apt/lists/*

COPY ALMACEN.pl ./ALMACEN.pl
COPY backend ./backend
COPY frontend ./frontend

ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["python3", "backend/server.py"]