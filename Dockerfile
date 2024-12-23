FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /app


COPY requirements.txt .


ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN pip install --no-cache-dir -r requirements.txt

COPY ./start.sh .
RUN sed -i 's/\r$//g' ./start.sh
RUN chmod +x ./start.sh


COPY . .


EXPOSE 8002

ENTRYPOINT ["./start.sh"]