#!/bin/bash
mkdir -p hat_online_results
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingAdaptiveTree 
        -s (generators.WaveformGenerator -i $seed) -i 1000000 -f 10000
    " > "./hat_online_results/$seed.csv"
done