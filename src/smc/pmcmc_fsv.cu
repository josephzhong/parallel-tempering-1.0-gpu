/*
 * pmcmc_fsv.cu
 *
 *  Created on: 27-Jan-2010
 *      Author: alee
 */

#include <stdio.h>
//#include <cutil.h>
#include "rng.h"
#include "gauss.h"
#include "output.h"
#include "kalman.h"
#include "matrix.h"
#include "fsv.h"
#include "smc_fsv.h"
#include "smc_lg.h"
#include "smc_usv.h"
#include "smc_mvlg.h"
#include "scan.h"
#include "usv.h"

void test_smc_fsv_forget(int N, int Dx, int Dy, int T, float* ys_real, float* scale_step,
        float* cov_step, float* h_args_l, int nb, int nt) {
//    unsigned int hTimer;
//    double time;
//    cutCreateTimer(&hTimer);

    float* d_xs;
    float* x_init;
    float* d_ys_real;

    float* xs = (float*) malloc(N * Dx * sizeof(float));
    cudaMalloc((void**) &d_xs, N * Dx * sizeof(float));
    cudaMalloc((void**) &x_init, N * Dx * sizeof(float));
    cudaMalloc((void**) &d_ys_real, T * Dy * sizeof(float));
    cudaMemcpy(d_ys_real, ys_real, T * Dy * sizeof(float), cudaMemcpyHostToDevice);

    float* ws = (float*) malloc(N * sizeof(float));
    float* d_ws;
    cudaMalloc((void**) &d_ws, N * sizeof(float));

    //  populate_randn_d(x_init, N * D);

    float* hx_init = (float*) malloc(N * Dx * sizeof(float));
    matrix_zero(hx_init, N, Dx);
    cudaMemcpy(x_init, hx_init, N * Dx * sizeof(float), cudaMemcpyHostToDevice);
    free(hx_init);

    float ll_forget_fsv;

//    cutResetTimer(hTimer);
//    cutStartTimer(hTimer);

    smc_forget_fsv(x_init, d_xs, d_ws, d_ys_real, N, Dx, Dy, T, h_args_l, scale_step, cov_step,
            &ll_forget_fsv, nb, nt);

//    cutStopTimer(hTimer);
//    time = cutGetTimerValue(hTimer);
//    printf("Time = %f, ", time);

    printf("ll_fsv_forget = %f\n", ll_forget_fsv);

    free(ws);
    free(xs);
    cudaFree(d_xs);
    cudaFree(x_init);
    cudaFree(d_ys_real);
}

void test_fsv(int M, int N, int T, int nb, int nt) {
    const int Dx = 3;
    const int Dy = 5;

    float theta[Dx + Dx * Dx + Dy * Dy]

    float scale_step[Dx * Dx];
    matrix_identity(scale_step, Dx);
    matrix_times(scale_step, scale_step, 0.9f, Dx, Dx);

    float cov_step[Dx * Dx] = { 0.5f, 0.2f, 0.1f, 0.2f, 0.5f, 0.2f, 0.1f, 0.2f, 0.5f };

    float Psi[Dy * Dy];
    matrix_identity(Psi, Dy);
    matrix_times(Psi, Psi, 0.5f, Dy, Dy);

    float B[Dy * Dx] = { 1.0f, 0.0f, 0.0f, 0.5f, 1.0f, 0.0f, 0.5f, 0.5f, 1.0f, 0.2f, 0.6f, 0.3f,
            0.8f, 0.7f, 0.5f };

    float* xs_real = (float*) malloc(T * Dx * sizeof(float));
    float* ys_real = (float*) malloc(T * Dy * sizeof(float));

    kill_rng();
    seed_rng(16384, 32, 128);

    generate_data_fsv(xs_real, ys_real, Dx, Dy, T, scale_step, cov_step, Psi, B);

    printf("%f\n", xs_real[T - 1]);

    to_file(xs_real, T * Dx, "fsv_xs_real.txt");
    to_file(ys_real, T * Dy, "fsv_ys_real.txt");

    float h_args_l[Dy * Dx + Dx * Dy + Dy * Dy];
    matrix_transpose(B, h_args_l + Dy * Dx, Dy, Dx);
    for (int i = 0; i < Dy * Dx; i++) {
        h_args_l[i] = B[i];
    }
    for (int i = 0; i < Dy * Dy; i++) {
        h_args_l[2 * Dy * Dx + i] = Psi[i];
    }

    kill_rng();
    seed_rng(8192, 32, 128);

    test_smc_fsv_forget(N, Dx, Dy, T, ys_real, scale_step, cov_step, h_args_l, nb, nt);

    free(xs_real);
    free(ys_real);
}

int main(int argc, char **argv) {

    //    int N = 8192;
    //    int N = 16384;
    //    int N = 32768;
    //    int N = 65536;
    //    int N = 262144;

    //    int N = 8192;
    //   int N = 16384;
    //    int N = 32768;
            int N = 4096;

//    int N = 131072;

    int nb = 32;
    int nt = 128;

    int T = 200;

    seed_rng(8192, 32, 128);

    scan_init(N);

    test_fsv(1, N, T, nb, nt);

    kill_rng();
    scan_destroy();
}
