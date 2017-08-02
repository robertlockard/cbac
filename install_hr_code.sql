-- install hr_code
conn hr_code/x@orcl

set role admin_hr_code identified by x;

-- again, just like the api, we are useing authid current_user.
-- this does not seem intutive. if a user can access the
-- api directly, code can be writen to access the api outside
-- of the code schema.
-- <EXPERMENT> with using definers rights.
create or repalce package pkgHREmp authid current_user as
