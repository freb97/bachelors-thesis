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
pdflatex -recorder -jobname=mydocument --interaction=batchmode -draftmode -shell-escape ${ENTRYFILE}
(cd ${OUTPUTDIR} && makeglossaries ${ENTRYFILE})
biber --quiet --input-directory=${OUTPUTDIR} --output-directory=${OUTPUTDIR} ${ENTRYFILE}
pdflatex --interaction=batchmode -shell-escape ${ENTRYFILE}

# Copy generated log file to build folder
cp ${OUTPUTDIR}/${ENTRYFILE}.log ${OUTPUTPDFDIR}

# Move PDF to build folder if generated successfully
if [ -f "${OUTPUTDIR}/${ENTRYFILE}.pdf" ]; then
  mv ${OUTPUTDIR}/${ENTRYFILE}.pdf ${OUTPUTPDFDIR}

  LOGOUTPUT=$(printf "Compilation finished, elapsed time: %s seconds\n" ${SECONDS})
else
  LOGOUTPUT=$(printf "Compilation finished with errors, elapsed time: %s seconds\n" ${SECONDS})
fi

# Output log to stdout and logfile
echo "${LOGOUTPUT}" && echo "${LOGOUTPUT}" >> ${OUTPUTDIR}/${ENTRYFILE}.log
