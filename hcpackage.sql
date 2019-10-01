set heading off
set linesize 300
set trimspool on
set feedback off
set verify off
spool temp.bat
 
select 'mkdir &1' || chr(13) || chr(10) ||
       'cd &1'
  from dual;
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr user -pw password -br -vn ' || v.mappedversion || chr(13) || chr(10) ||
        'rename ' || i.itemname || ' ' || i.itemname || '.' || v.mappedversion
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
   and lower(p.packagename) like lower('&1%');

select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr user -pw password -br -vn ' || min(to_number(v.mappedversion)-1) || chr(13) || chr(10) ||
       'rename ' || i.itemname || ' ' || i.itemname || '.' || min(to_number(v.mappedversion)-1)
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
   and lower(p.packagename) like lower('&1%')
 group by i.itemname, pfn.pathfullname, e.environmentname;

spool off
exit
