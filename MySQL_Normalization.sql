use onlinelearningschool;

select * from course_ratings_summaries;

alter table course_ratings_summaries
add column course_rating_summaries_id bigint not null auto_increment primary key first;

drop table Instructor;
create table Instructor
select instructor,course_id from courses;
alter table Instructor
add column Instructor_id bigint not null auto_increment primary key first;

select * from instructor;

create table courses_normalized
select courses.course_id, course_name, instructor.instructor_id,launch_date from courses
left join instructor
on courses.course_id= instructor.course_id;

create table Course_ratings_normalized
select rating_id, course_ratings.course_id, instructor_id, star_rating from course_ratings
left join courses_normalized
on courses_normalized.course_id=course_ratings.course_id;

create table course_rating_summaries_normalized
select course_rating_summaries_id,course_ratings_summaries.course_id,count_of_student_reviews,avg_star_rating from course_ratings_summaries
left join courses
on courses.course_id=course_ratings_summaries.course_id;

drop table course_ratings;
drop table course_ratings_summaries;
drop table courses;
