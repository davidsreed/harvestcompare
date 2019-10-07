set heading off
set linesize 300
set trimspool on
set feedback off
set verify off
spool temp.bat
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr &4 -pw &5 -br -vn ' || v.mappedversion
  from haritems@harrep_harvest i,
       harversions@harrep_harvest v,
       harpackage@harrep_harvest p,
       harenvironment@harrep_harvest e,
       harstate@harrep_harvest s,
       harpathfullname@harrep_harvest pfn
 where i.itemobjid = v.itemobjid
   and i.parentobjid = pfn.itemobjid
   and v.packageobjid = p.packageobjid
   and p.envobjid = e.envobjid
   and p.stateobjid = s.stateobjid
   and lower(itemname) = '&1'
   and v.mappedversion = '&2';
select 'rename &1 &1..&2' from dual;
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr &4 -pw &5 -br -vn ' || v.mappedversion
  from haritems@harrep_harvest i,
       harversions@harrep_harvest v,
       harpackage@harrep_harvest p,
       harenvironment@harrep_harvest e,
       harstate@harrep_harvest s,
       harpathfullname@harrep_harvest pfn
 where i.itemobjid = v.itemobjid
   and i.parentobjid = pfn.itemobjid
   and v.packageobjid = p.packageobjid
   and p.envobjid = e.envobjid
   and p.stateobjid = s.stateobjid
   and lower(itemname) = '&1'
   and v.mappedversion = '&3';
select 'rename &1 &1..&3' from dual;
select 'code --diff &1..&2 &1..&3' from dual;

spool off
exit
