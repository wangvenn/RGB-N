TF_INC=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')

nvcc -std=c++11 -c -o sequential_batch_fft_kernel.cu.o \
  sequential_batch_fft_kernel.cu.cc \
  -I $TF_INC -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

g++ -std=c++11 -shared -o ./build/sequential_batch_fft.so \
  sequential_batch_fft_kernel.cu.o \
  sequential_batch_fft.cc \
  -I $TF_INC -fPIC \
  -D_GLIBCXX_USE_CXX11_ABI=0 \
  -lcudart -lcufft -L/opt/common/cuda/cuda-8.0.44/lib64

rm -rf sequential_batch_fft_kernel.cu.o
