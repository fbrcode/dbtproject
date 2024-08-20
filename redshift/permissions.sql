-- sample group and user for dbt post hook test for model 'models/bireport.sql'
create group bi_users;
create user alex with password '123abc99PWD';
alter group bi_users add user alex;