-- we are going to create the users and roles 
-- we need. The user hr_api is going to have
-- access to the hr schema.
create user hr_api identified by x;

-- the user hr_code will have execute privs
-- on the packages in the hr_api schema.
create user hr_code identified by x;

-- the hr_decls package will hold constants
-- and type definations 
create user hr_decls identified by x;

-- the hr_errors schema will hold errors
-- that are raised. 
create user hr_errors identified by x;
-- the hr_errors schema needs privs 
-- on the tablespace to 
grant unlimited tablespace to hr_errors;

-- the hr_errors_reporter schema will hold
-- the code to create an error and report
-- back to the application the primary key
-- of the error stack that occured.
create user hr_errors_reporter identified by x;

create user app_user1 identified by x;

-- now for the roles we will need.
-- we are going to need a role for hr_api to
-- access the hr objects. this role will 
-- be assigned to the hr_api packages
-- that access the hr objects.

create role use_emp_role;

-- we need a role for help desk errors
-- this will be assigned to the help_desk_reporter
-- to collect and report errors. the role is going
-- to be assigned to help_desk_reporter and it'
-- reporting and collecing packages.
create role use_helpdesk_role;

-- 
create role hr_sel_emp_role;
create role hr_api_exec_role;
create role hr_errors_role;

-- once we are done, create session will be revoked.
-- create a admin_hr_api role that will have the privilege
-- create procedure.
create role admin_hr_api identified by x;
grant create procedure to admin_hr_api;
grant 
	create session,
	admin_hr_api
to hr_api;

grant 
	hr_sel_emp_role
to hr_api with delegate option;

grant 
	create session to 
	hr_code;

grant 
	hr_api_exec_role 
to hr_code with delegate option;

-- lets create an admin_hr_decls_role
-- that will be granted the create 
-- procedure privilege.

create role admin_hr_decls_role identified by x;
grant create procedure to admin_hr_decls_role;

grant 
	create session, 
	admin_hr_decls_role
to hr_decls;

-- this will force the user to enter the 
-- password of the role to make changes 
-- to the hr_decls schema.
alter user hr_decls default role none;

grant create session to hr_errors;
grant 
	hr_errors_role 
to hr_errors with delegate option;

grant create session to hr_errors_reporter;
grant hr_errors_role to 
	hr_errors_reporter 
with delegate option;

grant 
	create session,
	use_emp_role
to app_user1;

--