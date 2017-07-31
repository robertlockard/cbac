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

-- now for the roles we will need.
-- we are going to need a role for hr_api to
-- access the hr objects. this role will 
-- be assigned to the hr_api packages
-- that access the hr objects.

create role use_sel_emp_role;