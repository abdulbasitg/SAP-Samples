#!/bin/sh
rm -rf resources
rm -rf build
mkdir resources
cp -r apps build

npm install -g @ui5/cli

cd build

for d in *; do 
    echo "Starting to build : $d"
    cd $d
    echo "specVersion:"" \"2.4\"">ui5-central.yaml
    echo "metadata:">>ui5-central.yaml
    echo "  name:"" $d">>ui5-central.yaml
    echo "type:"" application">>ui5-central.yaml
    ui5 build --config=ui5-central.yaml --dest "../../resources/`basename $PWD`"
    cd .. 
done 
cd ..
rm -rf build