WORK_DIR=$(dirname $0)

NP=1
# NAME="Al2O3_3x3x1"
# NAME="AUSURF112"
# NAME="Si_hse"
KERNEL_NAME="regular_fft"
EXPT_NAME="$(date +"%Y-%m-%d")_ncu_${NAME}_ngpus$(printf "%02d" $NP)_${KERNEL_NAME}"
LAUNCH_SKIP=1000
LAUNCH_COUNT=10

cd $WORK_DIR/$NAME &&
ncu --target-processes all \
    -f -o ../nsight/$EXPT_NAME \
    --kernel-name $KERNEL_NAME \
    --launch-skip $LAUNCH_SKIP \
    --launch-count $LAUNCH_COUNT \
    ./run_pw_gpus.sh $NP