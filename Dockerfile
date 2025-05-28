ARG OKTETO_VERSION=1.31.0
FROM okteto/pipeline-runner:$OKTETO_VERSION
COPY bashrc /root/.bashrc
RUN git config --global http.timeout 300 && \
    git config --global core.sshCommand "ssh -o ConnectTimeout=300"
