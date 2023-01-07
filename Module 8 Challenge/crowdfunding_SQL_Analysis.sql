-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
select cf_id, backers_count from campaign
WHERE (outcome='live')
ORDER BY cf_id DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select count(cf_id), cf_id from backers
group by cf_id
ORDER BY cf_id DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 


SELECT first_name, last_name, email, goal - pledged as remaining_goal_amount 
INTO email_contacts_remaining_goal_amount
from contacts
INNER JOIN campaign
ON (contacts.contact_id = campaign.contact_id)
WHERE (outcome = 'live')
ORDER BY remaining_goal_amount DESC;

-- Check the table
SELECT * from email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select b.email, 
	b.first_name, 
	b.last_name, 
	b.cf_id, 
	cmp.company_name, 
	cmp.description, 
	cmp.end_date, 
	cmp.goal - cmp.pledged as "Left of Goal"
into email_backers_remaining_goal_amount
from campaign as cmp
inner join backers as b
on (cmp.cf_id = b.cf_id)
WHERE (cmp.outcome = 'live')
ORDER BY b.email DESC;
-- Check the table
select * from email_backers_remaining_goal_amount;