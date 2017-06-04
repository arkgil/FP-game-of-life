#!/bin/bash

set -e
sbt fastOptJS
cp ./target/scala-2.12/game-of-life-visualization-fastopt.js \
   ../backend/web/static/js/game-of-life-visualization.js
cp ./target/scala-2.12/game-of-life-visualization-jsdeps.js \
   ../backend/web/static/js/game-of-life-visualization-jsdeps.js
