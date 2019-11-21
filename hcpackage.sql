set heading off
set linesize 300
set trimspool on
set feedback off
set verify off
spool temp.bat

select 'rmdir /q /s &1' || chr(13) || chr(10) ||
       'mkdir &1' || chr(13) || chr(10) ||
       'cd &1'
  from dual;
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr &2 -pw &3 -br -tb -vn ' || v.mappedversion || chr(13) || chr(10) ||
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

/*
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr &2 -pw &3 -tb -br -vn ' || min(to_number(v.mappedversion)-1) || chr(13) || chr(10) ||
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
*/
select 'hco ' || i.itemname || ' -vp "' || pfn.pathfullname || '" -st "Perform Dev and Create Spec" -b "harvest2" -en "' || e.environmentname ||  '" -usr &2 -pw &3 -tb -br -vn ' || v.mappedversion || chr(13) || chr(10) ||
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
   and v.modifiedtime = (select max(v2.modifiedtime)
                           from haritems@harrep_harvest i2,
                                harversions@harrep_harvest v2
                          where i2.itemobjid = v2.itemobjid
                            and i2.itemobjid = i.itemobjid
                            and v2.inbranch = 0
                            and v2.modifiedtime < (select min(v3.modifiedtime)
                                                     from haritems@harrep_harvest i3,
                                                          harversions@harrep_harvest v3,
                                                          harpackage@harrep_harvest p3,
                                                          harenvironment@harrep_harvest e3,
                                                          harpathfullname@harrep_harvest pfn3
                                                    where i3.itemobjid = v3.itemobjid
                                                      and i3.parentobjid = pfn3.itemobjid
                                                      and v3.packageobjid = p3.packageobjid
                                                      and p3.envobjid = e3.envobjid
                                                      and lower(p3.packagename) like lower('&1%')
                                                      and i3.itemobjid = i.itemobjid));

spool off
exit
