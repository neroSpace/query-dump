select 
from_user as user
, COUNT(*) as total_emails
, RANK() OVER(ORDER BY COUNT(*) DESC, from_user ASC) as activity_rank
from google_gmail_emails
GROUP BY 1