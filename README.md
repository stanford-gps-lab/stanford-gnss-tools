# stanford-gnss-tools (sgt)
This is a toolbox with functions useful for coordinate transformations, data parsing and a host of other needs. MAAST users will be required to have this toolbox in their path.

For now, you can find some helpful tips and overview in the following sections:

 - [Setup](#setup)
 - [Naming Conventions](#naming-conventions)
 - [Project Structure](#project-structure)


## Setup ##

The easiest way to "setup" everything to be able to use the toolbox seamlessly in MATLAB is to add the `stanfordgnsstools` directory to your MATLAB path.  This will make everything within that directory accessible to you anywhere in MATLAB.


## Git Branch Structure ##

You'll notice that the repository currently has several branches.  Just want to briefly mention what some of the key branches are and some guidelines for naming other branches:

 - **master** - the master branch is the most recent, fully working and tested version of the code.  Think of this as what would be the stable production release build.
 - **development** - the development branch contains a nearly fully stable version of the code that has some of the newest features developed.  Each feature should be individually tested and known to work, but if there are issues caused by two features interacting, that can be handled on the development branch if needed (in general, you should make sure your feature isn't breaking any of the code before pushing to development).
 - **feature-branch** - all other branches should be where you are actively developing a feature (e.g. 'broadcast-algorithm-feature' would be where the broadcast algorithm is being developed).  Naming should be clear and simple with `-` used as the character for spaces as desired.  NOTE: when working on a feature, you might have a good working subset of that feature which can be pushed to development if you want, you don't need to wait until the entire feature is built out.

## Naming Conventions ##

Just so we can have some formatting consistency, let's all try and follow the same naming conventioned as outlined here:

(NOTE: I'm borrowing heavily from the MATLAB naming conventions that I've seen - MATLAB doesn't have anything formal - for a lot of the outward facing elements to make it seem more MATLABy)

 - **function** - functions should be **mixedCase** (e.g. `polarPlot`)

 - **classes** - classes should be **CamelCase** (e.g. `UserObservation`)

 - **class properties** - should be **CamelCase** (e.g. `UserObservation.Satellites`)

 - **class methods** - should be **mixedCase** (these are the same as functions)

 - **variables** - variable names should be **mixedCase**. An exception is if a variable name includes vector names (xyz, enu) in which case these can remain lower case.


## Project Structure ##

Just to help navigate the folder structure and what some of the symbols mean, here is a brief overview.

The top level directory (where this is file is) contains 1 directory:

 - `stanfordgnsstools` - the toolbox itself.  This is what you should add to your MATLAB path.  See the details below on how this is structured.


### The Toolbox ###

As mentioned above, the toolbox itself is contained in the `stanfordgnsstools` directory.  The toolbox uses some specific MATLAB syntax to name some of the directories (for specific details, check out [this link](https://www.mathworks.com/help/matlab/matlab_oop/scoping-classes-with-packages.html)).

A short summary of MATLAB directory syntax:

 - `+sgt` - directories that start with `+` create a `package` in MATLAB.  You can think about this as the same thing as a `namespace` in C++.  Basically it limits the scope of all the functions, classes, etc. within the package.  Therefore, to access something within this package, you would call it via `package.<function>`; for example `sgt.UniversalConstants` is how to access the `UniversalConstants` class.

 - `@UniversalConstants` - directories that start with `@` represent a set of files for a class.  Within this directory, there should be a file with the same name as the directory (e.g. `UniversalConstants.m`) that contain the class definition, including the constructor and ideally prototypes for all other functions.  The rest of the files in the directory are functions that act on or are a part of the class.


