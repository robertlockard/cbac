-- install the hr_api schema
conn hr_api/x@orcl

set role admin_hr_api identfied by x;

-- lets think about the authid current_user, this would imply that
-- the user executing the package must have insert into hr.employees
-- but that's not what we intend. we don't want the end user to
-- be able to access the tables directly.
--<EXPERMENT> use current_user but don't grant any privs to the
-- end user outside of execute on the package. then try definer.
-- as definer, the package will be executing with the current rights
-- of the role that is assigned (use_emp_role).
create or replace package pkgEmp_DML authid current_user as
	-- insert a row
	procedure pIns_emp(pEmpRec hr_decls.r.t_emp_row);
	-- select a row based on phone number
	procedure pSel_emp_by_phone(pPhoneNumber varchar2,
								pEmpRec hr_decls.r.t_emp_row);
end pEmp_DML;
/

-- note use_emp_role was granted to hr_api with delegate option.
-- because of this, we can grant the role to the package. at this
-- time the use_emp_role does not have any privileges.
grant use_emp_role to package pkgEmp_DML;

CREATE OR REPLACE PACKAGE BODY pkg_Emp_DML AS
	-- insert a row
	PROCEDURE pIns_emp(pEmpRec IN hr_decls.r.t_emp_row) IS
	BEGIN
		INSERT INTO hr.employess VALUES pEmpRec;
	END pIns_emp;
	-- select a row based on phone number
	PROCEDURE pSel_emp_by_phone(pPhoneNumber IN 	VARCHAR2,
								pEmpRec 		OUT hr_decls.r.t_emp_row) IS
	BEGIN
		SELECT *
		INTO pEmpRec
		FROM hr.employees
		WHERE phone_number = pPhoneNumber;
	END pSel_emp_by_phone;
END pkg_Emp_DML;
/
