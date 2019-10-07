echo ----------------------------------------------------------
echo example:
echo hc pkg_account_usage.pkb 162 163
echo ----------------------------------------------------------
set /p database=<database.txt
set /p harvestuser=<harvestuser.txt
set /p harvestpass=<harvestpass.txt
sqlplus utility/securit2019@samsdev_Samsd @hc %1 %2 %3 %harvestuser% %harvestpass%
call temp
