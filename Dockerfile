ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:23.09-py3

FROM $BASE_IMAGE
ENV PROJ_DIR=/workspace/GoLLE
RUN mkdir ${PROJ_DIR}
COPY . ${PROJ_DIR}
WORKDIR ${PROJ_DIR}
RUN pip install --upgrade pip && pip install -r requirements.txt