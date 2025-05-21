source .venv/bin/activate
conda deactivate

mv ~/.aws/credentials ~/.aws/credentials.bak
aws s3 ls s3://openpi-assets/ --no-sign-request
