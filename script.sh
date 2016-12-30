#!/bin/bash
# Use -q for silent script
main=$PWD
# echo $main
sage=7.0.4
echo "WP Project name?: "
read project

cd ..
mkdir $project

# Docker
sed "s/%PROJECT%/$project/g" development/docker-compose.yml > $project/docker-compose.yml

# WP
cp -R development/wp-content $project
ln -s $main/wp-plugins $project/wp-content/plugins
cd $project/wp-content/themes/

# Theme
wget -q https://github.com/todoconk/sage/archive/$sage.zip
unzip -q $sage.zip
rm $sage.zip
mv sage-$sage $project

# npm + bower + grunt
cd $project

ln -s $main/node_modules node_modules
ln -s $main/bower_components assets/vendor

# echo "prefix=$main/shared_node_modules" > .npmrc
# sed "s/%PROJECT%/$main/g" $main/.bowerrc > .bowerrc

npm install -s
grunt build

echo "Happy dev! =D"