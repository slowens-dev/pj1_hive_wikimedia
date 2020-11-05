use wikipedia;

--	create the table from the wiki_history dataset
--	enwiki data for 2020-09 is taken from the image creatd 2020-10
create table history
 (
  wiki_db string, 
  event_entity string,
  event_type string,
  event_timestamp string,
  event_comment string,
  event_user_id bigint,
  event_user_text_historical string,
  event_user_text string, 
  event_user_blocks_historical array<string>,
  event_user_blocks array<string>, 
  event_user_groups_historical array<string>,
  event_user_groups array<string>,
  event_user_is_bot_by_historical array<string>,
  event_user_is_bot_by array<string>,
  event_user_is_created_by_self boolean,
  event_user_is_created_by_system boolean,
  event_user_is_created_by_peer boolean,
  event_user_is_anonymous boolean,
  event_user_registration_timestamp string,
  event_user_creation_timestamp string,
  event_user_first_edit_timestamp string,
  event_user_revision_count bigint,
  event_user_seconds_since_previous_revision bigint,

  page_id bigint,
  page_title_historical string,
  page_title string, 
  page_namespace_historical int,
  page_namespace_is_content_historical boolean,
  page_namespace_ int,
  page_namespace_is_content boolean,
  page_is_redirect boolean,
  page_is_deleted boolean,
  page_creation_timestamp string,
  page_first_edit_timestamp string,
  page_revision_count bigint,
  page_seconds_since_previous_revision bigint,

  user_id bigint,
  user_text_historical string,
  user_text string,
  user_blocks_historical array<string>,
  user_blocks array<string>,
  user_groups_historical array<string>,
  user_groups array<string>, 
  user_is_bot_by_historical array<string>,
  user_is_bot_by array<string>, 
  user_is_created_by_self boolean,
  user_is_created_by_system boolean,
  user_is_created_by_peer boolean,
  user_is_anonymous boolean, 
  user_registration_timestamp string,
  user_creation_timestamp string, 
  user_first_edit_timestamp string, 

  revision_id bigint,
  revision_parent_id bigint,
  revision_minor_edit boolean,
  revision_deleted_parts array<string>,
  revision_deleted_parts_are_suppressed boolean,
  revision_text_bytes bigint,
  revision_text_bytes_diff bigint,
  revision_text_sha1 string, 
  revision_content_model string,
  revision_content_format string,
  revision_is_deleted_by_page_deletion boolean,
  revision_deleted_by_page_deletion_timestamp string,
  revision_is_identity_reverted boolean, 
  revision_first_identity_reverting_revision_id bigint,
  revision_seconds_to_identity_revert bigint,
  revision_is_identity_revert boolean, 
  revision_is_from_before_page_creation boolean, 
  revision_tags array<string>
  )
  row format delimited
  fields terminated by '\t';
 
--	load the data 
load data inpath '/user/hive/input/wiki_history/' into table history;

--	get the average time a reverted edit is visible before being reverted
--	in seconds, minutes, hours, and days
create table reverted_avg_time 
 as select
 round(avg(revision_seconds_to_identity_revert), 2) as seconds,                                                   
 round(avg(revision_seconds_to_identity_revert)/60, 2) as minutes,
 round(avg(revision_seconds_to_identity_revert)/3600, 2) as hours,
 round(avg(revision_seconds_to_identity_revert)/86400, 2) as days
 from history
 where revision_seconds_to_identity_revert > 0 
 and revision_is_identity_reverted=true ;     

--	we see that the average page that gets reverted to identity
--	is visible for about 3.2 days before being reverted.
--	now we look for the average number of monthly views
--	we divide it by 10 becuase 3.2 is roughly 10% of 30
--	to pages on enwiki
--	we will reuse our pageviews_09_en_monthly table
create table q5_answer
 as select 
 round( avg(views)/10, 2) as average_views
 from pageviews_09_en_monthly;
--	show the results
select * from q5_answer;
