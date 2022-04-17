#!/bin/bash

cd ~/jupyter-notebooks
jupyter-notebook --allow-root --no-browser --ip 0.0.0.0 --log-level DEBUG .
#python3 -m http.server 8888
