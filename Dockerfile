FROM python:3.12.1-bookworm

WORKDIR /usr/share/app

COPY . .

# Definir variables de entorno sin espacios alrededor del "="
ENV NAME=django \
    USER=django \
    PASSWORD=django \
    HOST=localhost \
    DJ_USER=django \
    DJ_PASSWORD=django \
    DJ_EMAIL=kiko4da4@gmail.com \
    URL=http://localhost

RUN pip install --upgrade --no-cache-dir --break-system-packages pip && \
    pip install --no-cache-dir --break-system-packages -r requirements.txt && \
    pip install --no-cache-dir --break-system-packages mysqlclient

COPY script.sh /usr/local/bin/script.s
RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3000

CMD ["/usr/local/bin/script.sh"]
