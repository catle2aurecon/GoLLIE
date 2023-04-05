#!/bin/bash
#SBATCH --job-name=CoLLIE_seqlen_1_A100
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --output=CoLLIE_seqlen_1_A100.out.txt
#SBATCH --error=CoLLIE_seqlen_1_A100.err.txt

source /ikerlariak/igarcia945/envs/pytorch2/bin/activate

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TOKENIZERS_PARALLELISM=true
export TRANSFORMERS_NO_ADVISORY_WARNINGS="true"

cd ../src || exit

python3 trainer.py ../CoLLIE_configs/CoLLIE-7B.yaml

# python3 trainer.py ../CoLLIE_configs/CoLLIE-7B_eval.yaml
