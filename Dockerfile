ARG ARG IMAGE=intersystemsdc/irishealth-community
FROM $IMAGE as builder
USER ${ISC_PACKAGE_MGRUSER}


WORKDIR /opt/AriticleSimilarity

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} bert /usr/irissys/bert
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} src src
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} user /usr/irissys/csp/user
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} iris.script iris.script

USER root



USER ${ISC_PACKAGE_MGRUSER}

RUN python3 -m pip install --target /usr/irissys/mgr/python sentence-transformers 

RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly

