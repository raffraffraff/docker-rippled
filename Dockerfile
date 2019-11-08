# STAGE 1: From ubuntu LTS base, install build utilities and compile mysql-ripple
FROM ubuntu:18.04 as build

# These are separate RUN steps because I don't care about this intermediate
# image size, but would like to cache successful layers of the build
RUN apt-get update
RUN apt-get install -y curl gpg
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" > /etc/apt/sources.list.d/bazel.list
RUN apt-get update && apt-get install -y \
    pkg-config zip g++ zlib1g-dev unzip python bazel git \
    libssl-dev default-jdk-headless libmariadbclient-dev
RUN git clone https://github.com/google/mysql-ripple.git
RUN cd mysql-ripple; \
    bazel build :all; \
    bazel test :all

# STAGE 2: From ubuntu LTS base, install deps and copy rippled binary
FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y libssl1.1 && \
    apt-get clean && \
    rm -rf /var/cache/apt

COPY --from=build /mysql-ripple/bazel-bin/rippled /usr/bin/
ENTRYPOINT ["/usr/bin/rippled"]
