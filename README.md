# SHeCoRe - Shell Configuration Restorer

Sample scripts and config files for restoring (or setting) shell and environment to your default, favorite state.

This tool has been prepared for private purpose so probably is useless for the rest of the world. In case you find it useful please find some short manual in this document.

Currently the scripts provide restoration of following settings:

* bash settings - aliases, prompt, environment variables or whatever you can place in *~/.bashrc*
* directories - list of directories you want to always have on each development/personal/work machine
* desired applications [to be done] - automatic application installation (Ubuntu apt and CentOS yum/dnf supported)

## Repository content

From the user point of vue this repository contains two types of items:

* scripts (especially main *shecore.sh*)
* profiles (different lists of settings to be applied)
* README file (document you're reading now)

### Scripts

Main script that everyone should use is *shecore.sh*. This script is responsible for applying selected profiles. It also has the most up-to-date usage description.

Scripts placed inside *./scripts* directory contains implementation of different functions used by *shecore.sh* and should never be called directly.

### Profiles (folders with settings)

Inside *./profiles* directory one can find some sample profiles and should also create it's own profiles when needed. Each profile is a separate directory and consists of following files:

* apps - list of applications to be installed on host
* bash - desired addition to user's *~/.bashrc* file (it will be placed inside separate file and sourced from *~/.bashrc*)
* dirs - list of directories to be created inside $HOME (creation of dirs in other locations currently not prepared)

Profile does not have to contain all of these files but only used ones.

## Fetching, installation and usage

*SheCoRe* is not a complex tools and does not need any installation process. To use it just download the repository and call *shecore.sh* script to create new profile or apply one/some of available profiles.

```bash
git clone https://github.com/markamdev/shecore
cd shecore
./shecore.sh
```

If you find this project usefull in your case then just fork it, upload your profiles and use on your machines.

## Author

If you need to contact me feel free to write me an email:
[markamdev.84#dontwantSPAM#gmail.com](maitlo:)
