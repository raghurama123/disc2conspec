# disc2conspec

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Fortran90](https://img.shields.io/badge/Language-Fortran90-red.svg)](https://en.wikipedia.org/wiki/Fortran)


This program reads a file with discrete values of excitation energies and oscillator strengths and prints a continuous spectrum in nm for plotting.

# How to compile?

    gfortran disc2conspec.f90 -o disc2conspec.x

# How to run? 

    ./disc2conspec.x     argument-1     argument-2
    
    argument-1 is the name of a file containing the discrete data in two columns. 
               Column-1 contains excitation energies and column-2 contains the corresponding 
               oscillator strength.
               
    argument-2 is choice of units. Allowed values are 'au2nm', 'ev2nm', 'cmi2nm', 'nm'

# Sample execution - 1 
#### Read energies in eV, see the contents of directory example_01

    raghurama$ ./disc2conspec.x inp.txt ev2nm
    
    generates the files spectrum.dat, spectrumstick.dat containing continuous and discrete energies in nm.
    
    raghurama$ gnuplot plot.gp 
    
    generates spectrum.eps that looks as follows
    
    ![](https://github.com/raghurama123/disc2conspec/example_01/spectrum.eps)
