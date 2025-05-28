ARG OKTETO_VERSION=1.31.0
FROM okteto/pipeline-runner:$OKTETO_VERSION
COPY bashrc /root/.bashrc
