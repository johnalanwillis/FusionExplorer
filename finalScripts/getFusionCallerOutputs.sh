#!/bin/bash
#generates a list of fusion caller output locations by type given a project root
#and target flag

#############Define Vars###############
jobLoc=$2
targetFlag=$1
outputLoc=$3

jobDate=$(date +%Y-%m-%d)

#the type of output to be parsed is specified by the targetFlag
#f indicates a FusionCatcher job
#S indicates a STARFusion job
#of indicates an oncofuse processed fusioncatcher job
#os indicates an oncofuse processed starfusion job
if echo "${targetFlag}" | grep -q "of"; then
    targetProg="oncofuse_fusionCatcher"
    outputFile="${outputLoc}""fusionOuts_""${targetProg}""_""${jobDate}"".txt"
    find "${jobLoc}" -wholename "*OncoFuse*FusionCatcher*1.00*.tsv" > "${outputFile}"

elif echo "${targetFlag}" | grep -q "os"; then
    targetProg="oncofuse_starFusion"
    outputFile="${outputLoc}""fusionOuts_""${targetProg}""_""${jobDate}"".txt"
    find "${jobLoc}" -wholename "*OncoFuse*STARFusion*1.5.tsv" > "${outputFile}"

elif echo "${targetFlag}" | grep -q "f"; then
    targetProg="fusionCatcher"
    outputFile="${outputLoc}""fusionOuts_""${targetProg}""_""${jobDate}"".txt"
    find "${jobLoc}" \( -wholename "*FusionCatcher*1.00*final-list_candidate-fusion-genes.txt" \
	! -wholename "*oncofuse*" \) > "${outputFile}"

elif echo "${targetFlag}" | grep -q "s"; then
    targetProg="starFusion"
    outputFile="${outputLoc}""fusionOuts_""${targetProg}""_""${jobDate}"".txt"
    find "${jobLoc}" \( -wholename "*STARFusion*1.5*star-fusion.fusion_predictions.tsv" \
	! -wholename "*oncofuse*" \) > "${outputFile}"

fi


