FROM ubuntu:18.04
COPY . /app
RUN apt-get update -y
RUN apt-get install build-essential -y
RUN apt-get install cmake coinor-libcbc-dev coinor-libclp-dev coinor-libcoinutils-dev coinor-libosi-dev coinor-libcgl-dev doxygen bison flex -y
RUN apt-get install python -y
