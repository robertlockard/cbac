-- install the hr_api schema
conn hr_api/x@orcl

set role admin_hr_api identfied by x;

-- lets think about the authid current_user, this would imply that 
-- the user executing the package must have insert into hr.employees.
create or replace package pkgEmp_DML authid current_user as
	-- insert a row
	procedure pIns_emp(pEmpRec hr_decls.r.t_emp_row);
	-- select a row based on phone number
	procedure pSel_emp(pPhoneNumber varchar2,
					   pEmpRec hr_decls.r.t_emp_row);
end pEmp_DML;
/

-- note use_sel_emp_role was granted to hr_api with delegate option.
-- because of this, we can grant the role to the package. at this
-- time the use_sel_emp_role does not have any privileges.
grant use_emp_role to package pkgEmp_DML;
