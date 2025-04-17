#!/bin/bash
# This script submits GEM-MACH on cedar cluster (Compute Canada)
# ***** change to your own username and mail address *****

#SBATCH --time=00-00:10:00         # time (DD-HH:MM:SS)
#SBATCH --job-name="run_prep"     # job name

#SBATCH --cpus-per-task=32                # cpu per task
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=3G             # memory per cpu
#SBATCH --account=def-yorkaqrl
#SBATCH --mail-user=abc123456@gmail.com   # send an email to a specific address
#SBATCH --mail-type=BEGIN           # send an email when the job begins
#SBATCH --mail-type=FAIL          # send an email when the job fails
#SBATCH --mail-type=END          # send an email when the job ends
#SBATCH --output=username-%j.log                 # log file
#SBATCH --error=username-%j.err                  # error file

cd  $MY_DEFAULT_PATH
set | egrep SLURM  | sed -e 's/^/export /g' > reset_slurm_env
echo "slurm_hl2hl.py   --format MPIHOSTLIST > $SLURM_SUBMIT_DIR/hostfile" >> reset_slurm_env
echo "alias mpiexec='mpiexec --hostfile $SLURM_SUBMIT_DIR/hostfile ' " >> reset_slurm_env
echo "alias mpirun='mpirun --hostfile $SLURM_SUBMIT_DIR/hostfile ' " >> reset_slurm_env
source ./reset_slurm_env
module load StdEnv/2023 intel/2023.2.1 imkl/2023.2.0 openmpi/4.1.5  fftw/3.3.10
. ./.common_setup intel
. /$MY_DEFAULT_PATH/scripts/runprep.sh -dircfg $MY_DEFAULT_PATH/work-AlmaLinux-9.3-x86_64-intel-2021.10.0/configurations/os_v524_machOSrun5