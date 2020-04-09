-- ############################# Pre Processing #################################################
create database if not exists student_tracker; 
use student_tracker;
drop table if exists `student`;
drop table if exists `student_final`;
drop table if exists `temp_student`;
 
-- ##############################################################################################

-- ###################### final table ###########################################################

-- final table in which data will be stored
CREATE TABLE if not exists `student_final` (
  `id` int,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(45)
);

/* Assuming this data is already copied from the original table in the previous execution*/
insert into `student_final`(`id`,`first_name`,`last_name`,`email`) values (1,'Aladdin','Aladdin','abc@gmail');
insert into `student_final`(`id`,`first_name`,`last_name`,`email`) values (2,'tom','tom','tom@gmail');
insert into `student_final`(`id`,`first_name`,`last_name`,`email`) values (3,'jerry','jerry','abc@gmail');
insert into `student_final`(`id`,`first_name`,`last_name`,`email`) values (4,'bruno','bruno','bruno@gmail');
insert into `student_final`(`id`,`first_name`,`last_name`,`email`) values (5,'jack','jack','jack@gmail');

-- ##################################################################################################

-- ########################## Original Table ########################################################

-- table from which data will be copied to final table
-- records are added to this table and it will be copied to final table.
CREATE TABLE if not exists `student` (
  `id` int,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(45)
);

-- This data is already present in the original table
-- This is copied to the final table in the previous run (as mentioned in the above insert query)
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (1,'Aladdin','Aladdin','abc@gmail');
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (2,'tom','tom','tom@gmail');
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (3,'jerry','jerry','abc@gmail');
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (4,'bruno','bruno','bruno@gmail');
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (5,'jack','jack','jack@gmail');

-- These records are added to the original table later on and is to be copied to the final table
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (6,'Mia','Mia','Mia@gmail');
insert into `student`(`id`,`first_name`,`last_name`,`email`) values (7,'Jesse','Jeese','Jesse@gmail');

-- ###################################################################################################

-- #################### Temporary table ##############################################################

-- temporary table/staging table for processing
CREATE TABLE if not exists `temp_student` (
  `id` int,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(45)
);

-- ##################################################################################################

-- ############ SQL Logic for only copying newly added records from original to final table #########

-- fetching data from original table to temporary table
insert into `temp_student`
select * from student;

-- fetching data from final table to temporary table
insert into `temp_student`
select * from student_final;

-- identifying latest records from temporary table and moving it into final table
insert into `student_final`
select * from temp_student 
group by `id`,
`first_name`,
`last_name`,
`email`
having count(*) = 1;

-- ######################################################################################################
-- Done
