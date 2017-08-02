-- install hr_decls
conn hr_decls/x@orcl
-- we need to enable the admin_hr_decls_role
-- to make changes to the schema.
set role admin_hr_decls_role identified by x;

-- exception ? does not have a pragma Exception_Init.
alter session set Plsql_Warnings = 'Error:All, Disable:05021'
/

-- the package name r refers to references
-- wel will be using throughout the application.
create package r authid definer is
	-- cursor definations we need
	cursor emp_cur is
	select RowidToChar(rowid) rid,
		   employee_id,
		   first_name,
		   last_name,
		   email,
		   phone_number,
		   hire_date,
		   job_id,
		   salary,
		   commission_pct,
		   manager_id,
		   department_id
	from hr.employees;
	-- type definations we need.
	subtype t_emp_row is emp_cur%rowtype;
	
	type bulk_select_from_emp is record (
		qry		t_emp_row,
		hash_	varchar2(32),
		row_	t_emp_row);
end r;
/

-- lets give execute access on hr_decls.r to
-- the users that require them.
grant execute on r to hr_api;
grant execute on r to hr_code;
grant execute on r to app_user1;
