source .venv/bin/activate

uv run examples/libero/convert_libero_data_to_lerobot.py --data_dir /mnt/afs/xuyuan2/workspace/dataset/openvla_dataset/modified_libero_rlds

CUDA_VISIBLE_DEVICES=0 uv run scripts/compute_norm_stats.py --config-name pi0_libero_low_mem_finetune

XLA_PYTHON_CLIENT_MEM_FRACTION=0.9 uv run scripts/train.py pi0_libero_low_mem_finetune --exp-name=my_libero --overwrite

CUDA_VISIBLE_DEVICES=0 uv run scripts/serve_policy.py policy:checkpoint --policy.config=pi0_libero_low_mem_finetune --policy.dir=/mnt/afs/xuyuan2/workspace/openpi/checkpoints/pi0_libero_low_mem_finetune/my_libero/29999

# run client
export HOME=/mnt/afs/xuyuan2
source ~/.bashrc
cd ~/workspace/openpi/
source examples/libero/.venv/bin/activate
export PYTHONPATH=$PYTHONPATH:$PWD/third_party/libero
python examples/libero/main.py --args.task-suite-name libero_spatial
INFO:root:Total success rate: 0.9
INFO:root:Total episodes: 100

python examples/libero/main.py --args.task-suite-name libero_object
INFO:root:Total success rate: 0.95
INFO:root:Total episodes: 100

python examples/libero/main.py --args.task-suite-name libero_goal
INFO:root:Total success rate: 0.9
INFO:root:Total episodes: 100

python examples/libero/main.py --args.task-suite-name libero_10
INFO:root:Total success rate: 0.85
INFO:root:Total episodes: 100
