#!/bin/bash

	# concatenate the specific constaints in to a file with the whole problem
  cat model_start.lp > temp_$@.lp
  cat $@.lp >> temp_$@.lp
  cat model_end.lp >> temp_$@.lp
  	# optimise the file, stop optimisation after a single solution is found
  symphony -L temp_$@.lp -d > out_$@.txt
  	# search the output to see if a solution was found. If so, keep it, if not delete the output
  if grep -L "$Column names and values of nonzeros in the solution" out_$@.txt;
  then 
    echo solution found!
    echo $@ >> feasible.txt
  else
  	echo no solution found
    rm out_$@.txt
  fi
  rm temp_$@.lp

