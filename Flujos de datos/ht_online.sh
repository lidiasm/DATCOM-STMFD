#!/bin/bash
mkdir -p ht_online_results
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingTree 
        -s (generators.WaveformGenerator -i $seed) -i 100000 -f 10000
    " > "./ht_online_results/$seed.csv"
done