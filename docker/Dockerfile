# Get base image
FROM herter4171/ubuntu-moose:latest

# By default one core is used to compile
ARG compile_cores=1

# By default checkout mfem-moose branch
ARG WORKDIR="opt"
ARG hypre_git_sha="562c29a"

# Install apt dependencies
RUN apt-get update && apt-get install -y \
    clang-format-9 \
    curl \
    libboost-all-dev \
    libnetcdf-dev \
    libssl-dev \
    xxd \
    libfontconfig1-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libglew-dev \
    libglm-dev \
    libpng-dev \
    ninja-build

# Install CMake
RUN cd /$WORKDIR && \
    git clone https://github.com/Kitware/CMake.git && \
    cd CMake/ && \
    git checkout 78ae759 && \
    ./bootstrap && \
    make && \
    make install && \
    alias cmake='/$WORKDIR/CMake/bin/cmake'

# Install Hypre v2.16.0
RUN cd /$WORKDIR && \
    git clone https://github.com/hypre-space/hypre.git && \
    mv hypre hypre-2.16.0 && \
    cd hypre-2.16.0 && \
    git checkout "$hypre_git_sha" && \
    cd src/ && \
    ./configure --enable-debug --enable-shared --disable-fortran && \
    make -j && \
    cd ../.. && \
    ln -s hypre-2.16.0 hypre

# Install METIS 5.1.0
RUN cd /$WORKDIR && \
    curl -O http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz && \
    tar -zxvf metis-* && \
    cd metis-5.1.0 && \
    make config shared=1 && \
    make && \
    make install && \
    ln -s ../build/Linux-x86_64/libmetis/libmetis.so lib

# Install MUMPS
RUN cd /$WORKDIR && \
    git clone https://github.com/scivision/mumps && \
    cd mumps/ && \
    mkdir build && \
    cd build && \
    cmake --preset=build -DBUILD_SHARED_LIBS=on -Dscotch=true -Dintsize64=false -Darith="s;d;c;z" -Dautobuild=true  \
    -DCMAKE_INSTALL_PREFIX=/usr/local/ .. && \
    make && \
    make install

# Build MFEM and common miniapp
RUN cd /$WORKDIR && \
    git clone https://github.com/mfem/mfem.git && \
    cd mfem && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DMFEM_USE_MPI=YES -DMFEM_USE_METIS_5=YES -DMETIS_DIR=../../metis-5.1.0 \
    -DMFEM_USE_OPENMP=YES -DMFEM_THREAD_SAFE=NO -DMFEM_SHARED=YES -DCMAKE_CXX_FLAGS_DEBUG=-fPIC -DMFEM_USE_NETCDF=YES \
    -DMFEM_USE_MUMPS=YES -DMUMPS_REQUIRED_PACKAGES="" -DCMAKE_POLICY_DEFAULT_CMP0057=NEW  &&\
    make && \
    cd miniapps/common && \
    make

# Build GLVis
RUN cd /$WORKDIR && \
    git clone https://github.com/GLVis/glvis.git && \
    cd glvis/ && \
    mkdir build && \
    cd build/ && \
    cmake -G Ninja -DMFEM_DIR=/opt/mfem/build .. && \
    ninja

# Build Hephaestus
RUN cd /$WORKDIR && \
    git clone https://github.com/aurora-multiphysics/hephaestus.git && \
    cd hephaestus && \
    mkdir build && \
    cd build && \
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DMFEM_DIR=/$WORKDIR/mfem/build -DMFEM_COMMON_INCLUDES=/$WORKDIR/mfem/miniapps/common  .. && \
    make