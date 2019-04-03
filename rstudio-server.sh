#!/bin/sh
#SBATCH --job-name=rstudio-server
#SBATCH --partition=main
#SBATCH --time=08:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16000
#SBATCH --output=slurm_%j.out
#SBATCH --signal=USR2

module load singularity
export RSTUDIO_PASSWORD=$(openssl rand -base64 15)
export R_LIBS_USER='/gpfs/hpchome/taavi74/Projects/geo-rnaseq/.snakemake/conda/3936ea39/lib/R/library'

# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${USER}@${SLURM_SUBMIT_HOST}.$(dnsdomainname)

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${USER}
   password: ${RSTUDIO_PASSWORD}

When done using RStudio Server, terminate the job by:

1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:

      scancel -f ${SLURM_JOB_ID}

END

# By default the only host file systems mounted within the container are $HOME, /tmp, /proc, /sys, and /dev.
singularity exec $HOME/simg/singularity-rstudio.simg rserver --www-port ${PORT} --auth-none 0 --auth-pam-helper rstudio_auth
printf 'rserver exited' 1>&2
