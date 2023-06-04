SELECT
    DISTINCT
    fp.post_id
    , fr.poster
    , fp.post_text
    , fp.post_keywords
    , post_date
FROM facebook_posts fp
LEFT JOIN facebook_reactions fr ON fp.post_id = fr.post_id
WHERE fr.reaction = 'heart'