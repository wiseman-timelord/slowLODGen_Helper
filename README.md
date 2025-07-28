# slowLODGen_Helper

Description
It helps slowLODGen work on Oblivion (legacy), so if you have issues getting it to work, then you should use this. It does 2 things..
1. Fixes the batch file, it had the incorrect location of `pypy.exe`.
2. It allows the user to fix critical folder locations required for operation of `slowLODGen`.
3. It ensures that `slowLODGen` is run as admin, because if you dont then you will get a load of issues printed, that can be missed by user and will not be visible by the time you get to the end.

Instruction
1) Extract to location of "slowLODGen" folder, over-writing the original bat.
2) Run `Launch_slowLODGen_Helper.bat` as admin, this will allow the user to configure critical folders, or just leave them as they are shown to be.
3) Run `Launch_slowLODGen.bat` as admin, this will then hopefully process your LOD appropriately as the thing is designed to do.
4) Ensure to put MergedLOD.esm first place in the load order (done automatically by vortex).

Notation
- I did release it on Nexus, but because powershell code, it got rejected, instead of re-making it in python, I will just put it here. 
.his is about the 4th time this has happened with diff project, so no powershell projects if I intend it to go on Nexus. 
