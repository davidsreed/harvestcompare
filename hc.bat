echo ----------------------------------------------------------
echo example:
echo hc pkg_account_usage.pkb 162 163
echo ----------------------------------------------------------
sqlplus utility/password@samsdev_Samsd @hc %1 %2 %3
call temp
