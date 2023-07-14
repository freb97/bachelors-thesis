#!/bin/bash

# Configuration
INPUTDIR=/src
OUTPUTDIR=/build/temp
OUTPUTPDFDIR=/build
ENTRYFILE=main

# Create output directory if it doesn't exist
if [ ! -d "${OUTPUTDIR}" ]; then
  mkdir ${OUTPUTDIR}
fi

# Navigate to output directory
cd ${OUTPUTDIR} || exit

# Copy source data to build folder
cp -r ${INPUTDIR}/* ${OUTPUTDIR}/.

# Compile document
SECONDS=0
ERROR=false
pdflatex --interaction=batchmode -draftmode -shell-escape ${ENTRYFILE}
biber --quiet --input-directory=${OUTPUTDIR} --output-directory=${OUTPUTDIR} ${ENTRYFILE}
makeglossaries ${ENTRYFILE}
pdflatex --interaction=batchmode -draftmode -shell-escape ${ENTRYFILE}
pdflatex --interaction=batchmode -shell-escape ${ENTRYFILE}

# Move PDF to build folder if generated successfully
if [ -f "${OUTPUTDIR}/${ENTRYFILE}.pdf" ]; then
  mv ${OUTPUTDIR}/${ENTRYFILE}.pdf ${OUTPUTPDFDIR}

  LOGOUTPUT=$(printf "Compilation finished, elapsed time: %s seconds\n" ${SECONDS})
else
  ERROR=true
  LOGOUTPUT=$(printf "Compilation finished with errors, elapsed time: %s seconds\n" ${SECONDS})
fi

# Output log to stdout and logfile
echo "${LOGOUTPUT}" && echo "${LOGOUTPUT}" >> ${OUTPUTDIR}/${ENTRYFILE}.log

# Copy generated log file to build folder
cp ${OUTPUTDIR}/${ENTRYFILE}.log ${OUTPUTPDFDIR}

# Return exit code 1 on error
case $ERROR in
  (true)    exit 1;;
esac
