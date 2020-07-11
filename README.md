# ImageJ: Macro for measuring colocalization

This macro is incomplete and imperfect as at now and will be improved.

It is **not** working yet. This repo is meant to start developing it.

## Macro: separate.ijm

Separates images by layers and channels and saves the results in subdirectory by image name and layers. This is required for the following analysis.

* Run the script
* The channels and layer should **not** be split on opening - be sure to deactivate these options
* confirm all of the following dialogues


## Requirements

You need:

* Fiji (ImageJ)
* Addon: [Ijp-Toolkit](https://github.com/ij-plugins/ijp-toolkit/wiki/Fiji-Managed-Installation)

## Some Commands used in this script

``run`` - runs a command from the menu. Can also be directly recorded (Plugins > Macros > Record)


## References

### Image J Macro Language Documentation

* Macros in general: https://imagej.nih.gov/ij/developer/macro/macros.html
* Macro functions: https://imagej.nih.gov/ij/developer/macro/functions.html

## Used Examples

* Listing files recurively: https://imagej.nih.gov/ij/macros/ListFilesRecursively.txt
