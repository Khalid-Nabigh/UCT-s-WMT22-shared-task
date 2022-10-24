# University of Cape Town's WMT22 System: Multilingual Machine Translation for Southern African Languages
This repository provides guidelines for using our submission to the constrained track of the WMT22 Shared Task: Large-Scale Machine Translation Evaluation for African Languages. Our system is a single multilingual translation model that translates between English and 8 South / South East African Languages, as well as between specific pairs of the African languages.
## Supported Langauges
| Language  | Code |
| ------------- | ------------- |
| English  | eng  |
| Afrikaans  | afr  |
| Northern Sotho  | nso  |
| Shona  | sna  |
| Swati  | ssw  |
| Tswana  | tsn  |
| Xhosa  | xho  |
| Xitsonga  | tso  |
| Zulu  | zul  |
## Translation Directions
Our system translates between English and 8 South / South East African languages (Afrikaans, Northern Sotho, Shona, Swati, Tswana, Xhosa, Xitsonga, Zulu) and in 8 additional directions (Xhosa to Zulu, Zulu to Shona, Shona to Afrikaans, Afrikaans to Swati, Swati to Tswana, Tswana to Xitsonga, Xitsonga to Northern Sotho, Northern Sotho to Xhosa).
- `eng ⟷ afr`, `eng ⟷ nso`, `eng ⟷ sna`, `eng ⟷ ssw`, `eng ⟷ tsn`, `eng ⟷ xho`, `eng ⟷ tso`, `eng ⟷ zul`.
- `xho ⟶ zul`, `zul ⟶ sna`, `sna ⟶ afr`, `afr ⟶ ssw`, `ssw ⟶ tsn`, `tsn ⟶ tso`, `tso ⟶ nso`, `nso ⟶ xho`.
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
The output path `eng.out` will be a simple text file with one sentence per line, in the same order as the sentences appeared in the input path `afr.test`.
