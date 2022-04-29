#!/bin/bash
mkdir -p ejercicio_2.2.1
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingTree 
        -s (generators.WaveformGenerator -i $seed) -i 1000000 -f 10000
    " > "./ejercicio_2.2.1/$seed.csv"
done