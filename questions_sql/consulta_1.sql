#1.  How many unique accounts streamed in June 2021, how many total hours were streamed and the average of hours streamed per account?

SELECT 
    COUNT(DISTINCT ACCOUNT_ID) AS N_UNIQUE_ACCOUNTS, 
    -- from miliseconds to hours
    SUM(WATCH_LENGTH_MS) / 3600000 AS TOTAL_STREAM_HOURS,
    (SUM(WATCH_LENGTH_MS) / 3600000) / COUNT(DISTINCT ACCOUNT_ID) AS MEAN_STREAM_HOURS -- Average hours per account
    -- Using AVG(WATCH_LENGTH_MS) / 3600000 would give the average watch length per stream, not per account.
FROM 
    TABLE_A
WHERE 
    -- Include streams that started before July and ended after May
    START_DATE_EST <= '2021-06-30'
    AND END_DATE_EST >= '2021-06-01'
    -- Streams that started in May and ended in June should be included,
    -- as well as those that started in June but ended in a subsequent month.
    AND IS_STREAM = 1; -- Exclude non-stream observations