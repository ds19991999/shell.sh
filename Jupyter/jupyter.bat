@echo off
python3 -m pip install --upgrade pip --force-reinstall
python2 -m pip install --upgrade pip --force-reinstall

python2 -m pip install --upgrade pip
python2 -m pip install jupyter
python3 -m pip install ipykernel
python3 -m ipykernel install --user
pip2 install numpy
pip2 install scipy
pip2 install pandas
pip2 install matplotlib
pip2 install jupyter_nbextensions_configurator
pip2 install jupyter_contrib_nbextensions
pip2 install notedown
pip2 install --upgrade jupyterthemes

python3 -m pip install --upgrade pip
python3 -m pip install jupyter
python2 -m pip install ipykernel
python2 -m ipykernel install --user
pip3 install numpy
pip3 install scipy
pip3 install pandas
pip3 install matplotlib
pip3 install jupyter_nbextensions_configurator
pip3 install jupyter_contrib_nbextensions
pip3 install notedown
pip3 install --upgrade jupyterthemes


pause