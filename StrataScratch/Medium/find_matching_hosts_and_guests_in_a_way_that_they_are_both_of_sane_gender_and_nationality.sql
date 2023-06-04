SELECT
    DISTINCT
    ah.host_id
    , ag.guest_id
FROM airbnb_hosts ah
LEFT JOIN airbnb_guests ag 
ON ah.nationality = ag.nationality 
AND ah.gender = ag.gender