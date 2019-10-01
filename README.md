# harvestcompare

Checkout harvest files to compare locally

###Requirements
Sqlplus client install on your computer  
harvest workbench installed on your computer

###Setup
Modify hc.bat line 5 to use password of database utility user  
Modify hcpackage.bat line 5 to use password of database utility user  
Modify hc.sql line 7 and 22 to use your harvest user and password  
Modify hcpackage.sql line 11 and 26 to use your harvest user and password

###Optional Setup
Modify hc.sql line 37 to automatically run your compare software (Currrently configured to use Visual Studio code)

###Processes
#####hc.bat
Syntax: hc filename version1 version2
This will checkout 2 versions of a file from harvest, rename them with an extension that matches the version and then optionally run your compare utility.

For example  
hc filename.pks 100 101 will checkout and create 2 files filename.pks.100 and filename.pks.101

#####hcpackage.bat
Syntax: hcpackage packagename  
This will checkout all versions of all files associated with the packagename, including the latest version right before the package, where the packagename can just be the start of the package name to be unique.

For example
hcpackage jowco-30 will checkout and create all versions with the filename format similar to hc. It also puts it in a subdirectory that is the name of the packagename passed in.
