# .bash_alias_base
* Just source other alias files
## .bash_alias_conda
* .act [environment] : activate conda environment
* .deact : deactivate conda environment
* .list : printout conda environment list
## .bash_alias_custom
* My Linux Configuration and some alias for test
* Just ignore it.
## .bash_alias_Linux
* some Linux alias shortcut for convenince.
* shotcut of programming
	* .bashF5 : refresh .bashrc
	* py [python file] : shortcut of python
	* node : shortcut of pbsnodes
* shortcut of executable
	* v2xsf : v2xsf
	* xc : xcrysden
* shortcut of option
	* .unpack [file] : unzip zipped (.tar.gz) file
	* .unfold [file] : unzip zipped (.tar) file
	* ls : ls for all file (include hidden file) but extension is "tmp"
	* ll : ls with details
	* lt : ls with details and sort by last edited time
	* .ff [file] : find file by file name
* colors
	* Espape Character of Color.
	* use ".color" or see Util/colors.sh
## .bash_alias_QEDT
* QEDT script shortcut
* Utils : shortcut of Util/
	* simple Utils
		* .color : printout color
		* .gitUpload : macro of git upload.
			1. add all changes in current directory
			2. get current version from commit message
			3. add 1 to version
			4. git push to current branch
	* file Utils
		* .find [OPTION] [string] : find file that containig given string
		* .count [file] [string] : count string in file
		* .sizeof [OPTION] [path] : print size of files in path
		* .ss [path] : print size of files in path. sort by size
	* PBS Job Utils
		* .qdel [JobID] : qdel jod and check delete state
* Module : shortcut of Module/
	* .tail : tail -f file that ends with .out
	* .vi   : vi file taht ends with .out
* Draw : shortcut of Draw/
	* 
