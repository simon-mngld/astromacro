# ImageJ: Macro for measuring colocalization

This macro is incomplete and imperfect as at now and will be improved.

Tested for ImageJ **version 1.52**.

## Macro: separate.ijm

Separates images by layers and channels and saves the results in subdirectory by image name and layers. This is required for the following analysis.

* Run the script
* The channels and layer should **not** be split on opening - be sure to deactivate these options
* confirm all of the following dialogues

## Macro: astromacro.ijm

* Set the filetype at the beginng of the macro (shoulf be ``.tif`` if you used above script)
* As of this version, you must chose a directoy containing directories (again), which then contain the image files! Chosing the directory where the images are in will not work.


## Requirements

You need:

* Fiji (ImageJ)
* Addon: [Ijp-Toolkit](https://github.com/ij-plugins/ijp-toolkit/wiki/Fiji-Managed-Installation)

## Some Commands used in the macro scripts

``run`` - runs a command from the menu. Can also be directly recorded (Plugins > Macros > Record)

``setBatchMode(true)`` - the images are not displayed when opened. Increases speed, but should be switched off in order to see the results, e.g. when developing the algorithm

``waitForUser("")`` - the user has to click ok in order for the macro to continue - use if you want to take a look at the results at a certain point of the macro

## Some graphical commands explained

### Subtract Background
```
Process > Subtract Background
```
There is often an uneven background in the image. You do not want this to affect the analysis. Therefore, background can (and should), be subtracted from the image. Pixels whose intensity values are similar to the background will be
replaced with the mean background intensity value.




## References

### Image J Macro Language Documentation

* Macros in general: https://imagej.nih.gov/ij/developer/macro/macros.html
* Macro functions: https://imagej.nih.gov/ij/developer/macro/functions.html

#### Used Examples

* Listing files recurively: https://imagej.nih.gov/ij/macros/ListFilesRecursively.txt

### Further Ressources

* [Practical work 5: Image processing with ImageJ](https://www.cs.helsinki.fi/bioinformatiikka/mbi/courses/07-08/mt/imaging/practical5.pdf)
