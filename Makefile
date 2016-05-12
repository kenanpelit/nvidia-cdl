# Check if nvcc is already available in the environment
NVCC := $(shell command -v nvcc 2> /dev/null)

# Otherwise point to the default CUDA path 
ifndef NVCC
	NVCC=/usr/local/cuda/bin/nvcc
endif

# Try to locate CUDA if it's not in the default path
ifneq ("$(wildcard $(NVCC))","")
# The default PATH is good - nothing else to do
else ifneq ("$(wildcard /usr/local/cuda-7.5/bin/nvcc)","")
NVCC=/usr/local/cuda-7.5/bin/nvcc
else ifneq ("$(wildcard /usr/local/cuda-7.0/bin/nvcc)","")
NVCC=/usr/local/cuda-7.0/bin/nvcc
else ifneq ("$(wildcard /usr/local/cuda-6.5/bin/nvcc)","")
NVCC=/usr/local/cuda-6.5/bin/nvcc
endif

LIB=-L/usr/lib64/nvidia

PROGRAM=nvidia-cdl

$(PROGRAM):
	$(NVCC) -c -o $(PROGRAM).o $(PROGRAM).cu -I./
	$(NVCC) $(PROGRAM).o $(LIB) -lnvidia-ml -o $(PROGRAM) -lcudart_static

clean:
	rm -f $(PROGRAM) $(PROGRAM).o

