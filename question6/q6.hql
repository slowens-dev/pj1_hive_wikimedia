--	create a table for the number of times a revision
--	gets reverted for each page
--	ie the number of times that page has been vandalized
create table reversions_per_page as
 select page_title as title, count(*) as reversions
 from history
 where revision_seconds_to_identity_revert > 0 
 and revision_is_identity_reverted=true 
 group by page_title;

--	looking at the top 10 gives a good idea of the most 
--	vandalized pages during 2020-09
create table q6_answer
 as select * from reversions_per_page
 order by reversions desc limit 10;

--	showing the data we see that Teahouse is the most 
--	reverted page that is not an administrative page
select * from q6_answer;
