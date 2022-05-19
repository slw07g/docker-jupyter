A docker container to load and run jupyter notebooks. 

Usin g a container sucha s this to view Jupyter notebooks provides a more consistent user experience for people that may share jupyter notebooks.
More dependencies can be added to the docker container either modifying the Dockerfile or installing via the built container's bash cli  (the tools may not persist if you use the latter method).

```
To run the docker container, just run `jupyter.sh`

usage: bash ./jupyter.sh [-o <ovpn_file>] [-g <github_username>]
-n    | --notebooks_path         (optional)      Path to folder containing jupyter notebooks
-p    | --port                   (optional)      Local port to forward to jupyter notebook server in container
-h    | --help                            Brings up this menu

```
