/*
 * mcmc_gauss_mv.cu
 *
 *  Created on: 24-Feb-2009
 *      Author: alee
 */

#include "mcmc_gauss_mv.h"

#include "func.h"
#include "gauss.ch"

#define TARGET gauss_pdf
#define LOG_TARGET log_gauss_pdf
#define TYPE n_mv
#define NUM_AP 111

#include "mcmc_kernel_mv.cu"

void FUNC( metropolis_rwpop, TYPE)(int N, int D, float* d_array_init, float sigma,
		float* h_args_p, float* d_temps, float* d_array_out, int log, int nb,
		int nt) {
	switch (D) {
	case 1:
		FUNC( metropolis_rwpop, TYPE) <1,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
		break;
	case 2:
		FUNC( metropolis_rwpop, TYPE) <2,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
		break;
	case 3:
		FUNC( metropolis_rwpop, TYPE) <3,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
		break;
	case 4:
		FUNC( metropolis_rwpop, TYPE) <4,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
		break;
	case 5:
		FUNC( metropolis_rwpop, TYPE) <5,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
		break;
	default:
			break;
	}

}

void FUNC( metropolis_rw, TYPE)(int N, int D, float* d_array_init, float sigma,
		float* d_array_out, float* h_args_p, int log, int nb, int nt) {
	switch (D) {
	case 1:
		FUNC( metropolis_rw, TYPE) <1> (N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
		break;
	case 2:
		FUNC( metropolis_rw, TYPE) <2> (N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
		break;
	case 3:
		FUNC( metropolis_rw, TYPE) <3> (N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
		break;
	case 4:
		FUNC( metropolis_rw, TYPE) <4> (N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
		break;
	case 5:
		FUNC( metropolis_rw, TYPE) <5> (N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
		break;
	default:
		break;
	}
}

void FUNC( metropolis_rwpop_marginal, TYPE)(int N, int D, float* d_array_init, float sigma, float* h_args_p,
        float* d_temps, float* d_array_out, int log, int nb, int nt, int red) {
    switch (D) {
    case 1:
        FUNC( metropolis_rwpop_marginal, TYPE) <1,1> (N, d_array_init, sigma, h_args_p, d_temps, d_array_out, log, nb, nt);
        break;
    default:
            break;
    }

}
