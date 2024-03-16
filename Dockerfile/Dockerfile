FROM ubuntu
LABEL author="Gokul Technologies"
LABEL emai="gokulkrishnan31232gmail.com"
RUN echo "RUN ONE"
RUN apt update -y
RUN apt install git wget curl -y
RUN mkdir -p /app/test
COPY test.sh /app/test/test.sh
ENV PATH=$PATH:/app/test
RUN chmod +x /app/test/test.sh
RUN echo "RUN Two"
CMD ["test.sh"]