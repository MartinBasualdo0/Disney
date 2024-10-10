# 5. Indicate  for those who streamed Avengers Infinity War, how many days past since last stream and which was the last streamed content prior to Infinity War.
SELECT 
    A.ACCOUNT_ID,
    A.START_DATE_EST AS Infinity_War_Stream_Date,
    DATEDIFF(A.START_DATE_EST, B.last_stream_date) AS days_since_last_stream,--If there are no streams prior to Infinity War, the result should be null. 
    B.last_program_title AS last_streamed_content --If there are no streams prior to Infinity War, the result should be null. 
FROM
    ( -- Get the details of accounts that streamed "Marvel Studios Avengers: Infinity War"
      SELECT ACCOUNT_ID, PROGRAM_FULL_TITLE, START_DATE_EST
      FROM TABLE_A
      WHERE PROGRAM_FULL_TITLE = 'Marvel Studios Avengers: Infinity War'
    ) A
LEFT JOIN
    ( -- Get the last stream before "Marvel Studios Avengers: Infinity War" for each account
      SELECT 
          ACCOUNT_ID, 
          MAX(START_DATE_EST) AS last_stream_date,
          MAX(PROGRAM_FULL_TITLE) AS last_program_title
      FROM TABLE_A
      WHERE START_DATE_EST < (SELECT MIN(START_DATE_EST) 
                              FROM TABLE_A
                              WHERE PROGRAM_FULL_TITLE = 'Marvel Studios Avengers: Infinity War' 
                              AND ACCOUNT_ID = TABLE_A.ACCOUNT_ID) 
      GROUP BY ACCOUNT_ID
    ) B
ON A.ACCOUNT_ID = B.ACCOUNT_ID;
