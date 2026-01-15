WORK_DIR=$(dirname $0)

NP=2
NAME="Al2O3_3x3x1"
# NAME="AUSURF112"
EXPT_NAME="$(date +"%Y-%m-%d")_${NAME}_ngpus$(printf "%02d" $NP)"

cd $WORK_DIR/$NAME &&
nsys profile \
    --trace openacc,nvtx,osrt,mpi \
    --output ../nsight/$EXPT_NAME \
    --force-overwrite=true \
    ./run_pw_gpus.sh $NP

    # --capture-range nvtx \
    # --nvtx-domain-include=default \
    # --nvtx-capture "electrons" \
    # --env-var=NSYS_NVTX_PROFILER_REGISTER_ONLY=0 \