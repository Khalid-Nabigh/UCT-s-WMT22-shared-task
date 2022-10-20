# UCT-s-WMT22-shared-task
## Running the model
We have two bash scripts for installing the required pachages and running the model:
1. setup_conda_env.sh

This creates a new conda env, installs the required packages, and downloads the model and other files needed to run our model.
```
bash setup_conda_env.sh
```

2. run_inference.sh

Given source sentences in a **simple text file (one sentence per line)**, it runs our preprocessing pipeline and produces our model's translations of the sentences in a target language. This script should be run with the following command line arguments:
```
bash run_inference.sh <tgt> <src> <batch_size> <input_path> <output_path>.
```
For example:
```
bash run_inference.sh eng afr 8 afr.test eng.out
```
The output path eng.out will be a simple text file with one sentence per line, in the same order as the sentences appeared in the input path afr.test.
