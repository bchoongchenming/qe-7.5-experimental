#!/bin/bash
WORK_DIR=$(dirname $0)

ECHO="echo"
QE_HOME="" # Add path to q-e here.
PW_BIN="${QE_HOME}/PW/src/pw.x" # pw.x binary

# Experiment details
NAME="ausurf"
EXPT_NAME="$(date +"%Y-%m-%d")_${NAME}_ngpu$(printf "%02d" $NP)"
$ECHO ">> Running experiment: ${EXPT_NAME}"

# Directories
PSEUDO_DIR="./" # directory of pseudopotentials
EXPT_SAVE_DIR="${WORK_DIR}/save" 
$ECHO "save dir: = ${EXPT_SAVE_DIR}"

# Parallelization factors
NP=$1 # change the number of processors
NI=0 # number of images
NK=0 # number of pools
NB=0 # number of bands ## square root of total number of cores

NI_STR=$( if [ $NI -gt 0 ]; then echo "-ni ${NI}"; else echo ""; fi)
NK_STR=$( if [ $NK -gt 0 ]; then echo "-nk ${NK}"; else echo ""; fi)
NB_STR=$( if [ $NB -gt 0 ]; then echo "-nb ${NB}"; else echo ""; fi)

# MPI command: -np <num of GPUs>
MPI_COMMAND="mpirun -np ${NP}"

## PW command with parallelization factors
PW_COMMAND="${PW_BIN} ${NI_STR} ${NK_STR} ${NB_STR}"

# remove existing dir to prevent data corruption
if [ -d "$EXPT_SAVE_DIR" ]; then
  $ECHO "remove old dir ${EXPT_SAVE_DIR}"
  rm -r $EXPT_SAVE_DIR
fi

mkdir $EXPT_SAVE_DIR

# copy starting files
# cp -r pwscf.save.base $EXPT_DIR/pwscf.save

$ECHO "Running the scf calculation..."
$ECHO "$MPI_COMMAND $PW_COMMAND < $NAME.in > $EXPT_NAME.out"
$MPI_COMMAND $PW_COMMAND < $NAME.in > $EXPT_NAME.out
$ECHO "Ended!"