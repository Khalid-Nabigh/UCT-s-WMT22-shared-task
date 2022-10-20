#!/bin/sh


eval "$(conda shell.bash hook)"
conda activate pywmt

# Process arugments
t=$1
s=$2
tokens=$3
input=$4
output=$5

if [ $s = afr ]
then
  s=af
elif [ $s = eng ]
then
  s=en
elif [ $s = xho ]
then
  s=xh
elif [ $s = zul ]
then
  s=zu
fi

if [ $t = afr ]
then
  t=af
elif [ $t = eng ]
then
  t=en
elif [ $t = xho ]
then
  t=xh
elif [ $t = zul ]
then
  t=zu
fi


# Prepare folders
downloads=downloads
vocab=$downloads/fairseq.vocab
tokenizer=$downloads/all_min_tokenizer.json
bin=bin
mkdir $bin
results=results
lang_list=$downloads/langs.txt
bpe=bpe_data
mkdir $bpe


echo "Applying BPE to source test file..."
# Apply BPE to source test file
python $downloads/encode2.py --model $tokenizer --input $input --output $bpe/bpe-test.$s
#echo "Done. Output written to bpe-$input"

echo "Apply fairseq-preprocess to file bpe-$input"
# Fairseq-preprocess source test file
python fairseq/fairseq_cli/preprocess.py --only-source --source-lang $s --target-lang $t \
    --testpref $bpe/bpe-test \
    --srcdict $vocab \
    --destdir $bin
cp bin/dict.$s.txt bin/dict.$t.txt
cp bin/dict.$s.txt bin/dict.$t.txt

#echo "Done. Output written to folder $bin."

pairs=xh-zu,xh-en,en-zu,zu-sna,zu-en,en-sna,sna-af,sna-en,en-af,af-ssw,af-en,en-ssw,ssw-tsn,ssw-en,en-tsn,tsn-tso,tsn-en,en-tso,tso-nso,tso-en,en-nso,nso-xh,nso-en,en-xh

echo $s
echo $t

echo "Generating translations..."
# Generate translations
python fairseq/fairseq_cli/generate.py $bin \
    --task translation_multi_simple_epoch --source-lang $s --target-lang $t --lang-pairs $pairs \
    --path $downloads/checkpoint_best.pt --encoder-langtok "src" --decoder-langtok \
    --max-tokens $tokens --beam 5 --results-path $results  --lang-dict "$lang_list"
grep ^H $results/generate-test.txt | LC_ALL=C sort -V | cut -f3- > $results/hypotheses.test
python $downloads/decode2.py --input $results/hypotheses.test --output $output

