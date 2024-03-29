#!/usr/bin/env bash

#/*============================================================================
#
#  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.
#
#  Copyright (c) University College London (UCL). All rights reserved.
#
#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.
#
#  See LICENSE.txt in the top level directory for details.
#
#============================================================================*/

# Script which changes generic name PHAS0100LSAAssignment2, namespace pa2 etc to a project name of your choice.
# USAGE: Just change the variables prefixed by NEW below to an appropriate name then run the script.

######################################################
##                 EDIT THIS PART                   ##
######################################################

NEW_PROJECT_NAME_CAMEL_CASE='PHAS0100LSAAssignment2'
NEW_PROJECT_NAME_LOWER_CASE='phas0100lsaassignment2'
NEW_PROJECT_NAME_CAPS='PHAS0100LSAASSIGNMENT2'
NEW_SHORT_DESCRIPTION='PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.'
NEW_NAMESPACE='pa3'


######################################################

# Strings to replace
OLD_DIR_NAME='PHAS0100LSAAssignment2'
OLD_PROJECT_NAME_CAMEL_CASE='PHAS0100LSAAssignment2'
OLD_PROJECT_NAME_LOWER_CASE='phas0100lsaassignment2'
OLD_PROJECT_NAME_CAPS='PHAS0100LSAASSIGNMENT2'
OLD_DOXYGEN_INTRO='PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.'
OLD_SHORT_DESCRIPTION='PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.'
OLD_NAMESPACE='pa3'

#### Replacements ###
move_command="mv"
is_git_repo=`find . -type d -name "[.]git" | wc -l`
if [ ${is_git_repo} -gt 0 ]; then
  echo "Running on a git repository."
  move_command="git mv --force"
fi

find_and_replace_string(){
    find . -type f | grep -v "[.]git" > $HOME/tmp.$$.files.txt
    for f in `cat $HOME/tmp.$$.files.txt`
    do
      wc1=`file $f | grep text | wc -l`
      wc2=`file --mime $f | grep "application/xml" | wc -l`
      if [ ${wc1} -gt 0 -o ${wc2} -gt 0 ]; then
        cat $f | sed s/"${1}"/"${2}"/g > $HOME/tmp.$$.file.txt
        mv $HOME/tmp.$$.file.txt $f
      fi
    done
    rm $HOME/tmp.$$.files.txt
}

find_and_replace_filename(){
    find . -name "*$1*" > $HOME/tmp.$$.files.txt
    wc=`cat $HOME/tmp.$$.files.txt | wc -l`
    if [ $wc -gt 0 ]; then
      change_name_command="cat $HOME/tmp.$$.files.txt | sed -e \"p;s/$1/$2/\" | xargs -n2 ${move_command}"
      eval ${change_name_command}
    fi
}

find_and_replace_filename_and_string(){
    find_and_replace_filename $1 $2
    find_and_replace_string $1 $2
}

# Change comment at top of each file describing project
find_and_replace_string "${OLD_SHORT_DESCRIPTION}" "${NEW_SHORT_DESCRIPTION}"

# Change Doxygen intro
find_and_replace_string "${OLD_DOXYGEN_INTRO}" "${NEW_SHORT_DESCRIPTION}"

# Replace name PHAS0100LSAAssignment2, phas0100lsaassignment2, PHAS0100LSAASSIGNMENT2 etc.
find_and_replace_string "$OLD_PROJECT_NAME_CAMEL_CASE" "$NEW_PROJECT_NAME_CAMEL_CASE"
find_and_replace_string "$OLD_PROJECT_NAME_LOWER_CASE" "$NEW_PROJECT_NAME_LOWER_CASE"
find_and_replace_string "$OLD_PROJECT_NAME_CAPS" "$NEW_PROJECT_NAME_CAPS"

# namespace
find_and_replace_string "namespace $OLD_NAMESPACE" "namespace $NEW_NAMESPACE"
find_and_replace_string "${OLD_NAMESPACE}::" "${NEW_NAMESPACE}::"

# Filename replacements
find_and_replace_filename "$OLD_PROJECT_NAME_CAMEL_CASE" "$NEW_PROJECT_NAME_CAMEL_CASE"
find_and_replace_filename "$OLD_PROJECT_NAME_LOWER_CASE" "$NEW_PROJECT_NAME_LOWER_CASE"
find_and_replace_filename "$OLD_PROJECT_NAME_CAPS" "$NEW_PROJECT_NAME_CAPS"

# mp prefixes
nc=`echo ${OLD_NAMESPACE} | wc -c | tr -d '[:space:]'`
for g in .h .cpp .ui .cmake
do
  find . -name "${OLD_NAMESPACE}*${g}" > $HOME/tmp.$$.${OLD_NAMESPACE}.${g}.txt
  for f in `cat $HOME/tmp.$$.${OLD_NAMESPACE}.${g}.txt`
  do
    basename $f $g | cut -c ${nc}-10000 >> $HOME/tmp.$$.prefixes.txt
  done
  rm $HOME/tmp.$$.${OLD_NAMESPACE}.${g}.txt
done
cat $HOME/tmp.$$.prefixes.txt | sort -u > $HOME/tmp.$$.prefixes.sorted.txt
for f in `cat $HOME/tmp.$$.prefixes.sorted.txt`
do
  echo "${f}\.cpp" >> $HOME/tmp.$$.prefixes.all.txt
  echo "${f}_h" >> $HOME/tmp.$$.prefixes.all.txt
  echo "${f}\.h" >> $HOME/tmp.$$.prefixes.all.txt
  echo "${f}\.ui" >> $HOME/tmp.$$.prefixes.all.txt
  echo "${f}" >> $HOME/tmp.$$.prefixes.all.txt
done

declare -a file_names=(`cat $HOME/tmp.$$.prefixes.all.txt`)
for i in "${file_names[@]}"
do
    find_and_replace_filename_and_string "${OLD_NAMESPACE}${i}" "${NEW_NAMESPACE}${i}"
done
rm $HOME/tmp.$$.prefixes.txt
rm $HOME/tmp.$$.prefixes.sorted.txt
rm $HOME/tmp.$$.prefixes.all.txt
