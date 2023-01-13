srcDIR=/home/wandrille/Documents/supportProjects/201911_Thaler_KleeCOI/pyKleeBarcode/src


for N in 105 210 315 420 525 629 734 839 944
do
 for rep in 0 1 2 3 4 5 6 7 8 9
 do
  EXP=random${N}_${rep}
  DIR=results_random_exp/$EXP
  echo $DIR
  mkdir -p $DIR
  grep "^>" sourceFasta/Mammalia_selected.fa | sort -R | head -n $N > $DIR/selected.txt
  grep -f $DIR/selected.txt -A 1 sourceFasta/Mammalia_selected.fa | grep -v "^--$" > $DIR/selected.fa 

  SOURCE=$EXP
  python $srcDIR/pyKleeBarcode_computeRefMat_MPI.py -i $DIR/selected.fa -o $DIR/${SOURCE}_ref.Ssum -s 0


  python $srcDIR/pyKleeBarcode_computeIndicatorVector_MPI.py -i sourceFasta/Mammalia_selected.fa \
                                                              -S $DIR/${SOURCE}_ref.Ssum \
                                                              -o $DIR/Mammalia_selected.${SOURCE}_ref.indicVectors.csv  -s 0


  python $srcDIR/pyKleeBarcode_computeStructureMatrix.py -i $DIR/Mammalia_selected.${SOURCE}_ref.indicVectors.csv \
                                                        -o $DIR/Mammalia_selected.${SOURCE}_ref.stMat.bin
 done
done
