#!/bin/bash
mkdir -p hat_offline_results
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateModel -m (
        LearnModel -l trees.HoeffdingAdaptiveTree
        -s (generators.WaveformGenerator -i $seed) -m 1000000) 
        -s (generators.WaveformGenerator -i 26) -i 1000000
    " > "./hat_offline_results/$seed.csv"
done