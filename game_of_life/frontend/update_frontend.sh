#!/bin/bash

set -e
sbt fullOptJS
cp ./target/scala-2.12/game-of-life-visualization-opt.js \
   ../backend/web/static/js/game-of-life-visualization.js
cp ./target/scala-2.12/game-of-life-visualization-jsdeps.js \
   ../backend/web/static/js/game-of-life-visualization-jsdeps.js
