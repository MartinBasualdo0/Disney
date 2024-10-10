#3. What other content watched those that streamed Loki?

SELECT DISTINCT PROGRAM_FULL_TITLE
FROM TABLE_A
WHERE ACCOUNT_ID IN (
    -- Subquery to find accounts that streamed Loki
    -- Consider using SERIES_ID instead of SERIES_FULL_TITLE for better performance if available and indexed
    SELECT DISTINCT ACCOUNT_ID
    FROM TABLE_A
    WHERE SERIES_FULL_TITLE = 'Loki'
)
AND SERIES_FULL_TITLE != 'Loki';
