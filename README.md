# Parallel Tempering in CUDA (GPU implementation)

This repository includes code that implements the Parallel Tempering MCMC algorithm in CUDA. It is based on the previously published code by Anthony Lee, available here: http://www.oxford-man.ox.ac.uk/gpuss/cuda_mc.html

This version has the following extras:
- Parallelized likelihood (intra-chain) computations with customizable granularity
- Unrolled reduction operation to compute the sum in the likelihood
- Customizable number of data in the likelihood, without an upper bound. This is done by storing the data in the global GPU memory instead of the constant GPU memory (as in the original code).
- Use of the shared GPU memory to temporarily store chunks of data during computations. All threads in a CUDA block have access to these shared chunks of data. 
