## Getting started

**In slurm cluster**

Create directory for singularity images and go into that directory:
```bash
mkdir ~/simg
cd ~/simg
```

Load singularity module and download the pre-built image from Singularity Hub:
```bash
module load singularity
singularity pull --name singularity-rstudio.simg shub://tpall/singularity-rstudio
```

Start Rstudio server as a regular slurm job. Note the jobid printed to terminal.
```bash
sbatch rstudio-server.sh
```

Print slurm log with instructions how to start SSH tunnel and login password. Replace *jobid* with your jobid.
```bash
less -F slurm_jobid.out
```

**In your computer**

Follow instructions in slurm log.


