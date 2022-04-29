#!/bin/bash
mkdir -p ejercicio_2.1.1
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateModel -m (
        LearnModel -l trees.HoeffdingTree 
        -s (generators.WaveformGenerator -i $seed) -m 1000000) 
        -s (generators.WaveformGenerator -i 26) -i 1000000
    " > "./ejercicio_2.1.1/$seed.csv"
done