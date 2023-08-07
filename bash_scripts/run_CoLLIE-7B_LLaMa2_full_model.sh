#!/bin/bash
#SBATCH --job-name=CoLLIE-7B_LLaMa2
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=128G
#SBATCH --output=.slurm/CoLLIE-7B_LLaMa2.out.txt
#SBATCH --error=.slurm/CoLLIE-7B_LLaMa2.err.txt

source /ikerlariak/osainz006/venvs/collie/bin/activate

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TOKENIZERS_PARALLELISM=true
export TRANSFORMERS_NO_ADVISORY_WARNINGS=true
export WANDB_ENTITY=hitz-collie
export WANDB_PROJECT=CoLLIE
export WANDB__SERVICE_WAIT=300
export OMP_NUM_THREADS=16

export PYTHONPATH="$PYTHONPATH:$PWD"
CONFIGS_FOLDER="configs/model_configs"

#torchrun --standalone --nproc_per_node=4 src/run.py ${CONFIGS_FOLDER}/CoLLIE-7B_LLaMa2_FSDP.yaml

accelerate launch --num_processes=4 \
--use_fsdp \
--mixed_precision=bf16 \
--fsdp_auto_wrap_policy=TRANSFORMER_BASED_WRAP  \
--fsdp_transformer_layer_cls_to_wrap="LlamaDecoderLayer" \
--fsdp_sharding_strategy=1 \
--fsdp_state_dict_type=SHARDED_STATE_DICT \
--fsdp_use_orig_params false \
src/run.py ${CONFIGS_FOLDER}/CoLLIE-7B_LLaMa2_FSDP.yaml
