/*
 * mcmc_mix_gauss_mu.cu
 *
 *  Created on: 26-Feb-2009
 *      Author: alee
 */

#include "mcmc_mix_gauss_mu.h"

#include "func.h"
#include "mix_gauss_uniform.ch"

#define TARGET mgu_mu_pdf
#define LOG_TARGET log_mgu_mu_pdf
#define TYPE mgumu_mv
#define NUM_AP 8198

#include "mcmc_kernel_mv.cu"

void FUNC(metropolis_rwpop, TYPE)(int N, int D, float* d_array_init, float sigma,
		float* h_args_p, float* d_temps, float* d_array_out, int log, int nb,
		int nt) {
	switch (D) {
	case 1:
		FUNC(metropolis_rwpop, TYPE)<1,1>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
		break;
	case 2:
		FUNC(metropolis_rwpop, TYPE)<2,1>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
		break;
	case 3:
		FUNC(metropolis_rwpop, TYPE)<3,1>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
		break;
	case 4:
		FUNC(metropolis_rwpop, TYPE)<4,1>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);

	default:
		break;
		}
		
}

void FUNC(metropolis_rw, TYPE)(int N, int D, float* d_array_init, float sigma,
		float* d_array_out, float* h_args_p, int log, int nb, int nt) {
	switch (D) {
	case 1: FUNC(metropolis_rw, TYPE)<1>(N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
			break;
	case 2: FUNC(metropolis_rw, TYPE)<2>(N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
			break;
	case 3: FUNC(metropolis_rw, TYPE)<3>(N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
			break;
	case 4: FUNC(metropolis_rw, TYPE)<4>(N, d_array_init, sigma, d_array_out, h_args_p, log, nb, nt);
			break;
	default:
		break;
	}
}

void FUNC(metropolis_rwpop_marginal, TYPE)(int N, int D, float* d_array_init,
		float sigma, float* h_args_p, float* d_temps, float* d_array_out,
		int log, int nb, int nt, int red) {
	switch (D) {
	case 1: FUNC(metropolis_rwpop_marginal, TYPE)<1,128>(N, d_array_init, sigma, h_args_p, d_temps,
			d_array_out, log, nb, nt);
			break;
	case 2: FUNC(metropolis_rwpop_marginal, TYPE)<2,128>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
	case 3: FUNC(metropolis_rwpop_marginal, TYPE)<3,128>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
	case 4: 

		switch (red) {
			case 32768:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,32768>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 16384:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,16384>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 8192:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,8192>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 4096:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,4096>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 2048:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,2048>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 1024:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,1024>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 512:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,512>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 256:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,256>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 128:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,128>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 64:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,64>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 32:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,32>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 16:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,16>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 8:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,8>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 4:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,4>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 2:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,2>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			case 1:
				FUNC(metropolis_rwpop_marginal, TYPE)<4,1>(N, d_array_init, sigma, h_args_p, d_temps,
				d_array_out, log, nb, nt);
				break;
			default:
				break;
			}	
	default:
		break;
	}
}
