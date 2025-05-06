FROM ubuntu:latest
WORKDIR /usr/src/app
COPY A.sh B.sh ./
RUN chmod +x A.sh B.sh
CMD ["bash", "-c", "./A.sh && ./B.sh"]
