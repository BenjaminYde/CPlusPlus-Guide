FROM ubuntu:22.04

# Development APT packages
RUN apt -qq update && \
    apt -qq install -y --no-install-recommends \
        sudo \
        git \
        wget \
        curl \
        zip \
        unzip \
        tar \
        ca-certificates \
        build-essential \
        gcc \
        g++ \
        gdb \
        make \
        ninja-build \
        autoconf \
        automake \
        locales-all \
        dos2unix \
        rsync \
        tar \
        ssh \
        python3 \
        && \
    apt -qq clean && \
    apt -qq autoclean && \
    apt -qq remove && \
    apt -qq autoremove

# Install CMAKE
ENV CMAKE_VERSION 3.28.1
RUN apt update && \
    apt -qq install -y --no-install-recommends \
        graphviz \
    && \
    cd /tmp && \
    wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    tar -xzvf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    mv cmake-${CMAKE_VERSION}-linux-x86_64 /opt/cmake && \
    rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
ENV PATH="/opt/cmake/bin:${PATH}"

# Install VCPKG
#RUN apt update && \
#    cd /tmp && \
#    wget --no-check-certificate https://github.com/microsoft/vcpkg/archive/refs/tags/2023.02.24.tar.gz && \
#    tar -xzvf 2023.02.24.tar.gz && \
#    mv vcpkg-2023.02.24 /opt/vcpkg && \
#    rm 2023.02.24.tar.gz && \
#    cd /opt/vcpkg && \
#    ./bootstrap-vcpkg.sh
#ENV PATH="/opt/vcpkg:${PATH}"

# Download Clang from source
ENV CLANG_VERSION 17.0.6
RUN apt update && \
    cd /tmp && \
    curl -LO https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-${CLANG_VERSION}.tar.gz && \
    tar -xvf llvmorg-${CLANG_VERSION}.tar.gz && \
    rm llvmorg-${CLANG_VERSION}.tar.gz

# Build Clang from source
#RUN apt update && \
#    cd /tmp/llvm-project-llvmorg-${CLANG_VERSION} && \
#    mkdir build && cd build && \
#    cmake \
#        -DLLVM_ENABLE_PROJECTS="clang" \
#        -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi" \
#        -DLLVM_TARGETS_TO_BUILD="X86" \
#        -DLLVM_INCLUDE_TESTS=OFF \
#        -DCMAKE_BUILD_TYPE=Release \
#        -G "Unix Makefiles" \
#        ../llvm \
#        && \
#    make clang -j $(nproc)

# Install Clang from source
#RUN cd /tmp/llvm-project-llvmorg-${CLANG_VERSION} && \
#    mv build /opt/clang-${CLANG_VERSION}
#ENV PATH="/opt/clang-${CLANG_VERSION}/bin:${PATH}"

# Download and install Clang binaries
RUN cd /tmp && \
    curl -L -O https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG_VERSION}/clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-22.04.tar.xz && \
    tar -xf clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-22.04.tar.xz && \
    rm      clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-22.04.tar.xz
    
# Install Clang
RUN cd /tmp && \
    mkdir /opt/clang-${CLANG_VERSION} && \
    mv clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-22.04/* /opt/clang-${CLANG_VERSION}
ENV PATH="/opt/clang-${CLANG_VERSION}/bin:${PATH}"

# Install ZSH
RUN sudo apt install -y zsh && \
    sudo chsh -s /usr/bin/zsh && \
    # Install oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    # configure .zshrc
    cd ~ && \
    touch .zshrc && \
    sed -i 's/ZSH_THEME=.*/ZSH_THEME="eastwood"/' .zshrc && \
    echo "ZSH Installed"

ENTRYPOINT ["/usr/bin/zsh"]

WORKDIR /home/benjaminyde