# QEDT
* Quantum Espresso Draw Tools(QEDT) is Tools for Draw or Plot Band Structure, Phonon Dispersion, Raman Spectra, etc.
## Directories
* .bash_alias
	* some alias for convenince
	* all alias start with "."
	* read .bash_alias/README.md
	* usage:
```
# ignore .bash_alias_custom. it is just my environment.
vi [your QEDT path]/.bash_alias/.bash_alias_base
{ignore source .bash_alias_custom}
# open .bash file
vi ~/.bashrc
# wirte to .bashrc file
. [your QEDT path]/.bash_alias/.bash_alias_base
# save .bashrc file and refresh
~/.bashrc
```
* bash_example: some example for using bash script
* Draw: Draw/Plot with python
* Module: Module for Using QE or Linux Terminal.
* OS: Check OS State.
* py_file: Check python State.
* tmp: unfinished files. this directory exists for test.
* Util: Util for Using QE or Linux Terminal.

## Requirments
* bash
	* Some Bash Script may require bash4.
* python
	* matplotlib
	* numpy
