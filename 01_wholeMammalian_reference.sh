
srcDIR=/home/wandrille/Documents/supportProjects/201911_Thaler_KleeCOI/pyKleeBarcode/src

REF=Mammalia_selected
SOURCE=Mammalia_selected

python $srcDIR/pyKleeBarcode_computeRefMat_MPI.py -i sourceFasta/${REF}.fa -o results/${REF}_ref.Ssum -s 0

python $srcDIR/pyKleeBarcode_computeIndicatorVector_MPI.py -i sourceFasta/$SOURCE.fa \
                                                           -S results/${REF}_ref.Ssum \
                                                           -o results/$SOURCE.${REF}_ref.indicVectors.csv  \
                                                           -s 0

python $srcDIR/pyKleeBarcode_computeStructureMatrix.py -i results/$SOURCE.${REF}_ref.indicVectors.csv \
                                                       -o results/$SOURCE.${REF}_ref.stMat.bin

