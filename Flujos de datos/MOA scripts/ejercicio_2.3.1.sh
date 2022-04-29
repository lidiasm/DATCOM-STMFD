#!/bin/bash
mkdir -p ejercicio_2.3.1
for seed in $(seq 30)
do
    java -cp moa.jar -javaagent:sizeofag-1.0.4.jar moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingTree 
        -s (generators.RandomRBFGeneratorDrift -i $seed -r $seed
        -c 2 -a 7 -n 3 -k 3 -s 0.001) -i 2000000 -f 100000
    " > "./ejercicio_2.3.1/$seed.csv"
done