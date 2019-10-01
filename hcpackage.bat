echo ----------------------------------------------------------
echo example:
echo hcpackage jowco-30
echo ----------------------------------------------------------
sqlplus utility/password@samsdev_Samsd @hcpackage %1
call temp
