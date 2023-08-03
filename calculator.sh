#!/usr/bin/env bash
# shellcheck disable=SC2162
welcome="Welcome to the basic calculator!"
instruction="Enter an arithmetic operation or type 'quit' to quit:"
history_file="operation_history.txt"
farewell="Goodbye!"

function validate_input() {
  re='^[-]?[0-9]*[.]?[0-9]+[ ]?[-\/*+^][ ]?[-]?[0-9]*[.]?[0-9]+$'
  [[ "$1" =~ $re ]] && echo true || echo false
}

function main() {

  echo "$welcome" | tee $history_file

  while true; do
    echo "$instruction" | tee -a $history_file && read operation
    echo "$operation" >> $history_file

    if [[ $operation =~ 'quit' ]]; then
      echo "$farewell" | tee -a $history_file
      break
    else
      check_operation "$operation" | tee -a $history_file
    fi
  done
}

function check_operation() {
  if [[ $(validate_input "$1") == true ]]; then
    arithmetic_result=$(echo "scale=2; $1" | bc -l)
    printf "%s\n" "$arithmetic_result"
  else
    echo "Operation check failed!"
  fi
}

main