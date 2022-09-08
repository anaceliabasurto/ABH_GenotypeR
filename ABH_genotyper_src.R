library (ABHgenotypeR)
         
#ABH genotype R
## Se utiliza esta libreria para imputar genotipos
## por medio de deslizamiento de ventanas

## Se lee el archivo con formato *ABH* y se asigna el nombre de cada parental
genotypes <- readABHgenotypes("~/tgbs_data/Genotype_corrector/CR_60/60_2/60_OK/F2_60_CR_final.csv",
                              nameA = "PY", nameB = "CH", readPos = T) 
summary(genotypes)
plotGenos(genotypes)
plotGenos(genotypes, chromToPlot = 12)

## Se imputa el genotipo en base a los alelos flanqueantes

postImpGenotypes <- imputeByFlanks(genotypes)

## Se reporta el numero de genotipos dentro del objeto "postImpGenotypes"
reportGenos(postImpGenotypes)

plotGenos(genotypes, chromToPlot = 1)
plotGenos(postImpGenotypes,chromToPlot = 1)

ErrCorr1Genotypes <- correctUndercalledHets(postImpGenotypes, maxHapLength = 3)

ErrCorr2Genotypes <- correctStretches(ErrCorr1Genotypes, maxHapLength = 3)

plotGenos(ErrCorr1Genotypes, chromToPlot = 1)
plotGenos(ErrCorr2Genotypes,chromToPlot = 1)

plotCompareGenos(genotypes, ErrCorr2Genotypes, chromToPlot = 1:3)

plotMarkerDensity(genos = ErrCorr2Genotypes)

plotAlleleFreq(genos = genotypes)
plotAlleleFreq(genos = ErrCorr2Genotypes)

#** writeABHgenotypes(ErrCorr2Genotypes, outfile = "F2_ABHcorrected_final.csv")

