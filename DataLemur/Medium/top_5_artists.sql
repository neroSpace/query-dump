SELECT *
FROM(
  SELECT 
    a.artist_name,
    -- COUNT(*) as Appearance,
    DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) Rank
  FROM artists a
  JOIN songs s ON a.artist_id = s.artist_id
  JOIN global_song_rank g ON s.song_id = g.song_id
  WHERE g.rank <= 10
  GROUP BY 1
  ORDER BY 2) AS ranking_artist
WHERE Rank <= 5