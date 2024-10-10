# 2. How many account watched series in the week of June 28th to July 4th in Argentina?
SELECT COUNT(DISTINCT ACCOUNT_ID) AS N_ACCOUNTS
FROM TABLE_A
WHERE 
    -- The stream must have started on or before July 4 and ended on or after June 28
    START_DATE_EST <= '2021-07-04'  -- Stream started on or before July 4
    AND END_DATE_EST >= '2021-06-28'  -- Stream ended on or after June 28
    AND ACCOUNT_HOME_COUNTRY = 'AR'   -- Argentina-based accounts
    AND PROGRAM_TYPE = 'episode';     -- Series (episode) streams
