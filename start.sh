#!/bin/bash

# Main script execution

./create-cluster.sh start

./create-cluster.sh create -f

# Initialize a variable to control the loop
continue_loop=1

# Define the signal handler function
handle_signal() {
  echo "Signal received!"
  continue_loop=0 # Set the variable to exit the loop
  ./create-cluster.sh stop
}

# Trap the SIGUSR1 signal and call the handler function
trap handle_signal SIGUSR1 SIGINT

# Loop until the signal is received
while [ $continue_loop -eq 1 ]; do
  sleep 1
done

echo done
