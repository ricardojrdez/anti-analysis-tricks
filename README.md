# anti-analysis-tricks
Bunch of techniques potentially used by malware to detect analysis environments

# Content
After some years, I decided to release these codes for the community. This material was prepared for training courses given in several security conferences. Namely, NoConName 2011, RootedCON 2013, and Hack in Paris 2013.

# Preparation
There is a toy GUI (baseProject) used to test each of the tricks individually. Each trick is implemented as an ASM macro. At the beginning, this macro is invoked and the value of detection is set to a variable which is later tested. You need to comment/uncomment the include of the trick you wish to test, and then compile the executable each time. Some tricks may need further modifications, you will find required instructions in each file. 

The main purpose of this project is to test how each anti-analysis trick can be overridden. A brief description of the technique is written in the first lines of each file.

# Dependencies
You will need to install RadASM IDE (https://fbedit.svn.sourceforge.net/svnroot/fbedit/RadASM30/Release/RadASM.zip + MASM dependencies) and MASM32 SDK compiler (http://www.masm32.com/download.htm)

# License
The project is released under GNU/GPL version 3.0

