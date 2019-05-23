## Python and Homebrew Notes

### Summary of Homebrew Python

Python 2 is being replaced by Python 3 and by the end of January
2020 Python 2 will reach its End of Life date (see [PEP 373](https://legacy.python.org/dev/peps/pep-0373/)).
The [Official Homebrew Documentation](https://docs.brew.sh/Homebrew-and-Python) has information on how
Homebrew installs Python. To allow developers to write code in either Python 2.x or Python 3.x during
this migration, Homebrew has set up its Python installation like so:

- The `python` and `python3` Homebrew formulae are installed
- The `python3` command points to Homebrew's Python 3.x (provided by the `python3` formula)
- The `python2` command points to Homebrew's Python 2.x (provided by the `python` formula)
- The `python` command, for now, points to Homebrew Python 2.x. This will likely change when python 2 reaches its End of Life.    
  **Note**: If Homebrew is not installed correctly with the PATH setup correctly, or the `python` and `python3` packages formulae are not installed then the `python` command will point to the Python executable that comes bundled
  with the macOS. It is better to avoid this situation where possible because it 
  is unconventional to use the macOS python executable in conjuction with any Homebrew Python installations.  
  **Note**: It isn't recommended to change `python` to point to Python 3.x. Some macOS
  system-wide programs depend on the `python` and they expect this to point to Python 2;
  changing `python` to point to Python 3.x could cause these programs not to behave correctly.

### Summary of Homebrew pip

Homebrew automatically installs Python's package management tool pip. When you install 
the `python` and `python3` formulae, the `pip` and `pip3` commands are automatically installed like so: 
- The `pip3` command will install packages under Homebrew's Python 3.x (provided by the `python3` formula)
- The `pip2` command will install packages under Homebrew's Python 2.x (provided by the `python` formula)
- The `pip` command, for now, install packages under Homebrew Python 2.x. This will likely change when python 2 reaches its End of Life status.

These Homebrew pip commands are system-side, the packages are installed globally and are accessible to python programs
that are executed with the appropriate version of Homebrew Python. Programs that run with Python 2.x can access packages installed using `pip2` (and for now, `pip`); and programs that are run with 
Python 3.x can access packages installed using `pip3`. This is summarised in the table below:


| Python Version   | Pip Install Command       | Package Install Path                               |
| ---------------- | ------------------------- | -------------------------------------------------- |
| Python 2.x       | `pip2 install <package>`  | `/usr/local/lib/python2.x/site-packages/<package>` |
| Python 3.x       | `pip3 install <package>`  | `/usr/local/lib/python3.x/site-packages/<package>` |      


### Virtual Environments (`virutalenv`, `venv`, `pipenv`, ...)

**Note:** There are tools for creating isolated project-specfic environments where
the version of Python, and the packages chosen, are fixed on per-project basis
rather than at the system level. These tools are installed by either 
using a Homebrew's `pip` command or by a Homebrew formula. 
Read this [Stack Overflow post](https://stackoverflow.com/a/41573588/3649209)
for more information about the tools for creating virtual environments.

| Tool             | Python 2.x                | Python 3.x                |
| ---------------- | ------------------------- | ------------------------- |
| virtualenv       | `pip2 install virtualenv` | `pip3 install virtualenv` |
| venv (pyvenv)    | `python2 -m venv`         | `python3 -m venv` |  

| Tool             | Homebrew Command        |
| ---------------- | ----------------------- |
| pyenv            | `brew install pyenv`    |  
| pipenv           | `brew install pipenv`    |  


### Binary Distributions (`setuptools`, `easy_install`, `eggs`, `wheel`, ...)

**Note:** There are tools for creating and install binary distributions.
These tools can be installed in Homebrew using Homebrew's `pip` command.
Read this [Stackoverflow post](https://stackoverflow.com/a/8550546/3649209)
for more information about tools to create binary distributions.


| Tool                                | Python 2.x                | Python 3.x                |
| ----------------------------------- | ------------------------- | ------------------------- |
| setuptools and easy_install         | `pip2 install setuptools` | `pip3 install setuptools` |
| wheel                               | `pip2 install wheel`      | `pip3 install wheel`      |  
| wheel (python 3.6+)                 | -                         | `pip3 wheel`              |  

