#!/bin/bash

###
# usage example:
# bash /opt/scripts/dl_isofit_data.sh
#
# Cleanup the existing folder before downloading 
# bash /opt/scripts/dl_isofit_data.sh --cleanup=true
#
# Default behavior is: false
#
###

# Set options
for i in "$@"
do
case $i in
    -cu=*|--cleanup=*)
    cleanup="${i#*=}"
    shift # past argument=value
    ;;
    *)
        # unknown option
    ;;
esac
done

# Defaults
cleanup="${cleanup:-false}"  # true/false

# Set conda env
eval "$(mamba shell hook --shell bash)"
mamba activate isofit

if [[ "$cleanup" == "true" ]]; then
    echo "*** Removing existing ISOFIT data before downloading ***"
    sleep 1
    rm -rf $HOME/isofit_data
else
    echo "*** Preserving existing ISOFIT data & updating anything new ***"
fi

echo ""
echo ""

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

# Create a symlink to /opt/scripts - on second thought maybe this isnt a good idea
# depending on what hub instance you log into the scripts folder will not be there leaving
# a blank directory in the users home folder
#ln -s /opt/scripts ~/opt_scripts

echo ""
echo ""
echo "ISOFIT input data and examples are now located in: "${HOME}"/isofit_data"
echo "************************************************************************************"
sleep 1

eval "$(mamba shell hook --shell bash)"

echo ""
echo ""
echo "To start using ISOFIT, run: mamba activate isofit"
echo "************************************************************************************"

echo ""
echo ""
echo "To test the ISOFIT code before proceeding, you can run: isofit --version"
echo ""
echo "To test the ISOFIT code before proceeding, from home you can run:"
echo "bash isofit_data/examples/20151026_SantaMonica/run.sh"
echo "************************************************************************************"


### EOF