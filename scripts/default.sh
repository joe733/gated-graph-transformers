#!/bin/bash
code=main_mol.py

dataset=ogbg-molhiv
expt=default

gnn=gated-gcn
num_layer=2
emb_dim=64
pos_enc_dim=-1
pooling='mean'

batch_size=256
epochs=2
lr=1e-3

seed0=0
seed1=1

tmux new -s $expt -d
tmux send-keys "conda activate ogb" C-m
tmux send-keys "
python $code --dataset $dataset --device 0 --expt_name $expt --gnn $gnn --num_layer $num_layer --emb_dim $emb_dim --pos_enc_dim $pos_enc_dim --pooling $pooling --batch_size $batch_size --epochs $epochs --lr $lr --seed $seed0 &
python $code --dataset $dataset --device 1 --expt_name $expt --gnn $gnn --num_layer $num_layer --emb_dim $emb_dim --pos_enc_dim $pos_enc_dim --pooling $pooling --batch_size $batch_size --epochs $epochs --lr $lr --seed $seed1 &
wait" C-m
tmux send-keys "tmux kill-session -t $expt" C-m
