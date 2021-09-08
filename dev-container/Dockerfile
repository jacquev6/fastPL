FROM ubuntu:20.04

# System packages
RUN set -x \
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
  build-essential wget  `# Basics` \
  libspdlog-dev libyaml-cpp-dev libpugixml-dev  `# Direct dependencies` \
  cmake  `# To build GoogleTest` \
  zlib1g-dev  `# For OR-Tools` \
 && rm -rf /var/lib/apt/lists/*

# Google Test
RUN set -x \
 && wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz \
 && tar xf release-1.10.0.tar.gz \
 && cd googletest-release-1.10.0 \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make \
 && make install \
 && cd ../.. \
 && rm -r googletest-release-1.10.0 \
 && rm release-1.10.0.tar.gz

# OR-Tools
RUN set -x \
 && wget https://github.com/google/or-tools/releases/download/v9.0/or-tools_ubuntu-20.04_v9.0.9048.tar.gz \
 && tar xf or-tools_ubuntu-20.04_v9.0.9048.tar.gz \
 && cd or-tools_Ubuntu-20.04-64bit_v9.0.9048 \
 && cp lib/* /usr/local/lib \
 && cp -r include/* /usr/local/include \
 && cd .. \
 && rm -r or-tools_Ubuntu-20.04-64bit_v9.0.9048 \
 && rm or-tools_ubuntu-20.04_v9.0.9048.tar.gz

# Matplot++
RUN set -x \
 && wget https://github.com/alandefreitas/matplotplusplus/releases/download/v1.1.0/matplotplusplus-1.1.0-Linux.tar.gz \
 && tar xf matplotplusplus-1.1.0-Linux.tar.gz \
 && cd matplotplusplus-1.1.0-Linux \
 && cp -r lib/* /usr/local/lib \
 && cp -r include/* /usr/local/include \
 && cd .. \
 && rm -r matplotplusplus-1.1.0-Linux \
 && rm matplotplusplus-1.1.0-Linux.tar.gz

# Ensure libraries put in /usr/local/lib are found by the loader.
# Keep this line *after* installing all librarie not provided by apt.
RUN ldconfig
