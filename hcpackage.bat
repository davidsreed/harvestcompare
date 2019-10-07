echo ----------------------------------------------------------
echo example:
echo hc jowco-30
echo ----------------------------------------------------------
set /p database=<database.txt
set /p harvestuser=<harvestuser.txt
set /p harvestpass=<harvestpass.txt
sqlplus %database% @hcpackage %1 %harvestuser% %harvestpass%
call temp
