# 4. Considering paid accounts only, evaluate duplication, interseccion and exclusivity for Luca, Raya and the Last dragon, and Soul films.
-- Instead of writing a separate query for each question, I opted to present the results in a single table.
-- The best approach depends on how the final results will be used.
SELECT 
    -- Intersection: Accounts that watched all three movies
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
       AND A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
       AND A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
     AND B.SUBSCRIPTION_STATE = 'paid') AS viewers_of_all_three,

    -- Accounts that watched both Luca and Raya, but not Soul
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
       AND A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Luca_and_Raya_only,

    -- Accounts that watched both Luca and Soul, but not Raya
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
       AND A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Luca_and_Soul_only,

    -- Accounts that watched both Raya and Soul, but not Luca
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
       AND A.ACCOUNT_ID IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Raya_and_Soul_only,

    -- Accounts that watched Luca exclusively
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.PROGRAM_FULL_TITLE = 'Luca'
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Luca_exclusive,

    -- Accounts that watched Raya exclusively
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.PROGRAM_FULL_TITLE = 'Raya and the Last Dragon'
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Soul')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Raya_exclusive,

    -- Accounts that watched Soul exclusively
    (SELECT COUNT(DISTINCT A.ACCOUNT_ID) 
     FROM TABLE_A A 
     JOIN TABLE_B B ON A.ACCOUNT_ID = B.ACCOUNT_ID 
     WHERE A.PROGRAM_FULL_TITLE = 'Soul'
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Luca')
       AND A.ACCOUNT_ID NOT IN 
         (SELECT DISTINCT ACCOUNT_ID FROM TABLE_A WHERE PROGRAM_FULL_TITLE = 'Raya and the Last Dragon')
     AND B.SUBSCRIPTION_STATE = 'paid') AS Soul_exclusive;
