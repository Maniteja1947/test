FROM    node:9-alpine
ADD     ./webdataconnector/. /
RUN     cd Simulator
EXPOSE  443
CMD     ["npm", "start"]
