## Getting started

**In slurm cluster**

1. Get Rstudio singularity image

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

(Optional) now you can unload singularity module.
```bash
module purge
```

2. Get this repository.

Clone this repo to *Projects* folder in user home directory (choose any other folder where you want to keep this repo). 
```bash
cd ~/Projects
git clone git@github.com:tpall/rstudio-slurm.git
cd rstudio-slurm
```

3. Start Rstudio server.

Start Rstudio server as a regular slurm job with `sbatch` command. Note the jobid printed to terminal.
```bash
sbatch rstudio-server.sh
```

Note: edit SBATCH lines in `rstudio-server.sh` file to specify time, memory etc limits or partition name.

Output will be something like this:
```
[tpall@hpc-cluster rstudio-slurm]$ sbatch rstudio-server.sh
Submitted batch job 5799356
```

Print slurm log with instructions how to start SSH tunnel and login password. Replace *jobid* with your batch jobid.
```bash
less -F slurm_jobid.out
```

**In your computer**

4. Start using Rstudio from your computer.

Start new terminal and go to web browser. Follow instructions in slurm log.


