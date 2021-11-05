#!/usr/bin/env bash
# 
# BEaSTSkullStrip.sh
# Using BEaST to do SkullStriping
# [see here](https://github.com/FCP-INDI/C-PAC/wiki/Concise-Installation-Guide-for-BEaST) for instructions for BEaST.
# 
# Qingyang Li
# 2013-07-29
#  
# The script requires AFNI, BEaST, MINC toolkit.

MincPATH='/opt/minc-1.9.15'
source $MincPATH/minc-toolkit-config.sh

MincLibPATH="$MincPATH/share/beast-library-1.1/"

MNItemplatePATH='~/Atlas'

cwd=`pwd`

if [ $# -lt 1  ]
then 
  echo " USAGE ::  "
  echo "  BEaSTSkullStrip.sh <input> [output prefix] " 
  echo "   input: anatomical image with skull, in nifti format " 
  echo "   output: The probram will output two nifti files " 
  echo "      1) a skull stripped brain image; "  
  echo "      2) a skull stripped brain mask. "
  echo "   Option: output prefix: the filename of the output files without extention"
  echo " Example: BEaSTSkullStrip.sh ~/data/head.nii.gz ~/brain " 
  exit
fi

if [ $# -eq 1 ]
then
  inputDir=$(dirname $1)
  if [ $inputDir == "." ]; then
    inputDir=$cwd
  fi

  filename=$(basename $1)
  inputFile=$inputDir/$filename

  extension="${filename##*.}"
  if [ $extension == "gz" ]; then
    filename="${filename%.*}"
  fi
  filename="${filename%.*}"

  out=$inputDir/$filename

else
  outputDir=$(dirname $2)
  if [ $outputDir == "." ]; then
  outputDir=$cwd
  out=$outputDir/$2
  else
    mkdir -p $outputDir
    out=$2
  fi

fi

workingDir=`mktemp -d`
echo " ++ working directory is $workingDir"
cd $workingDir
3dcopy $inputFile head.nii
nii2mnc head.nii head.mnc

flist=head.mnc
# Normalize the input
beast_normalize head.mnc head_mni.mnc anat2mni.xfm -modeldir $MNItemplatePATH
flist="$flist head_mni.mnc anat2mni.xfm"

# Run BEaST to do SkullStripping
# configuration file can be replaced by $MincLibPATH/default.2mm.conf or $MincLibPATH/default.4mm.conf

mincbeast -fill -median -conf $MincLibPATH/default.1mm.conf $MincLibPATH head_mni.mnc brain_mask_mni.mnc
flist="$flist brain_mask_mni.mnc"

# Trasform brain mask to it's original space
mincresample -invert_transformation -like head.mnc -transformation anat2mni.xfm brain_mask_mni.mnc brain_mask.mnc
flist="$flist brain_mask.mnc"

# Convert image from MNC to NII format.

mnc2nii brain_mask.mnc brain_mask_tmp.nii
3dresample -orient RPI -inset brain_mask_tmp.nii -prefix brain_mask_orig.nii
flist="$flist rain_mask_tmp.nii brain_mask_orig.nii"

# Generate and output brain image and brain mask
3dcalc -a brain_mask_orig.nii -b head.nii -expr "a*b" -prefix head_brain.nii.gz

flist="$flist head_brain.nii"

# out put files

# fix the AFNI won't overwrite problem.
rm -rf ${out}_brainmask.nii.gz ${out}_brain.nii.gz

3dcopy -inset brain_mask_orig.nii ${out}_brainmask.nii.gz
3dcopy -orient RPI -inset head_brain.nii.gz ${out}_brain.nii.gz

# delete all intermediate files
#rm -rf $flist
echo "  ++ working directory is $workingDir"
cd $cwd
