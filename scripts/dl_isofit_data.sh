#!/bin/bash

# Set conda env
eval "$(mamba shell hook --shell bash)"
mamba activate isofit

# Create a directory for isofit_data in the users home space
mkdir -p ~/isofit_data

# Confirm ISOFIT installed and working
echo "ISOFIT version: $(isofit --version)"

echo ""
echo ""
echo "Download ISOFT input data, examples, and tutorials"
echo "************************************************************************************"
sleep 1

# Download the required ISOFIT data and inputs
isofit -b ~/isofit_data download all

echo ""
echo ""
echo "Build ISOFIT examples and tutorials"
echo "************************************************************************************"
sleep 1

# Build the ISOFIT examples
isofit build

# Create a symlink to /opt/scripts
ln -s /opt/scripts ~/opt_scripts

### EOF