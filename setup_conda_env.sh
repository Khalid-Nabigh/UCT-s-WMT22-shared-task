#!/bin/sh


echo "Creating new conda environment..." 
yes | conda create -n pywmt python=3.8

eval "$(conda shell.bash hook)"
conda activate pywmt

echo $CONDA_PREFIX 

echo "Installing pytorch..."
yes | conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch

echo "Installing fairseq..."
git clone https://github.com/pytorch/fairseq.git
cd fairseq
pip install -r requirements.txt
python setup.py build develop
cd ..

echo "Donwloading model checkpoint..."
yes | conda install -c conda-forge gdown
gdown https://drive.google.com/uc?id=12ueEgaLr8avKvjZUsWVk-N0Pw5-hPNlM
tar -xzvf downloads.tar.gz
