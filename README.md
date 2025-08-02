# slowLODGen_Helper

Description
It helps slowLODGen work on Oblivion (legacy), so if you have issues getting it to work, then you should use this. It does 2 things..
1. Fixes the batch file, it had the incorrect location of `pypy.exe`.
2. It allows the user to fix critical folder locations required for operation of `slowLODGen`.
3. It ensures that `slowLODGen` is run as admin, because if you dont then you will get a load of issues printed at the start, that, can be missed by user and will not be visible by the time you get to the end.

Instruction
1) Ensure to haev "Powershell" upgraded to whatever is the highest level your OS supports, and in failing that or not wanting, then install Powershell Core 6+ (ask AI if you need help with "Upgrading my powershell version", remember mention your OS version).
- To check your powershell version (this should be 5.1+)...
powershell -NoLogo -NoProfile -Command $PSVersionTable.PSVersion
- To check your pwsh (powershell core) version (this should be 6+), this doesnt have to be present, but if it is you dont need to worry about powershell version (as SLG_H will run it with pwsh instead)...
pwsh -NoLogo -Command $PSVersionTable.PSVersion
2) Extract to location of "slowLODGen" folder, over-writing the original bat.
3) Run `Launch_slowLODGen_Helper.bat` as admin, this will allow the user to configure critical folders, or just leave them as they are shown to be.
4) Run `Launch_slowLODGen.bat` as admin, this will then hopefully process your LOD appropriately as the thing is designed to do.
5) Ensure to put MergedLOD.esm first place in the load order (done automatically by vortex).

Notation
- I did release it on Nexus, but because powershell code, it got rejected, instead of re-making it in python, I will just put it here. 
.his is about the 4th time this has happened with diff project, so no powershell projects if I intend it to go on Nexus. 
