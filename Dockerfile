FROM alpine:latest

ADD bin/acmetool /bin/acmetool
CMD /bin/acmetool

