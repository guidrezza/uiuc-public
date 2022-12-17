-- 1. __________________________________________
-- GUI: show google gcp components running
-- GUI: show database connection to cloud
-- KRIS: Show shell running frontend and backend
--
-- KRIS: show the website, call TJ
-- TJ: explain the frontend stuff, what you used to develop it, including the creative component
-- _____________________________________________

-- 2. __________________________________________
-- KRIS: Search for 'Kris Card' (should be empty)
-- KRIS: Mention how if the query is empty, nothing changes on the frontend
-- GUI: search for 'Kris Card' (should be empty)
--
-- KRIS: Insert 'Kris Card'
-- GUI: search for 'Kris Card' (should have an entry)
--
-- KRIS: Update 'Kris Card' (change whatever you want)
-- GUI: search for 'Kris Card' (show changes)
--
-- KRIS: Delete 'Kris Card'
-- GUI: search for 'Kris Card' (should be empty)
--
SELECT * FROM credit_cards WHERE card_name = 'Kris Card';
-- _____________________________________________

-- 3. __________________________________________
-- KRIS: briefly explain how the trending list is calculated, show the graph
-- KRIS: show trending card list, show how many clicks the top entry has
-- KRIS: search for that card on search tab
-- KRIS: show on the graph that the number of clicks for that card updated
--
-- GUI: search 'Bank Of America Premium Rewards Elite'
-- GUI: get # of clicks for 'Bank Of America Premium Rewards Elite'
-- KRIS: search 'Bank Of America Premium Rewards Elite', click on it ONCE
-- GUI: get # of clicks for 'Bank Of America Premium Rewards Elite'
-- KRIS: click on card 'Bank Of America Premium Rewards Elite' again
-- GUI: get # of clicks for 'Bank Of America Premium Rewards Elite'
--
-- GUI: explain how the TRIGGER blocks consecutive clicks from the same IP, run backend query twice
--
SELECT * FROM credit_cards WHERE card_name = 'Bank Of America Premium Rewards Elite';
SELECT COUNT(*) FROM click_logs WHERE card_id = 10000018;
-- _____________________________________________

-- 4. __________________________________________
-- GUI: show storage procedure code (and trigger code), call Mat
-- MAT: talk about what the storage procedure does
-- KRIS: run recommendation search
-- _____________________________________________

-- Q. __________________________________________
-- Explain your choice for the advanced database program and how it is suitable for
-- your application. For example, if you chose a stored procedure+trigger, explain
-- how this choice is suitable for your application.
--
-- How did the creative element add extra value to your application?
--
-- How would you want to further improve your application? In terms of database design and system optimization?
--
-- What were the challenges you faced when implementing and designing the application? How was it the same/different from the original design?
--
-- If you were to include a NoSQL database, how would you incorporate it into your application?
-- _____________________________________________

-- work distribution:
-- TJ: entire frontend
-- gui mat & kris worked closely on backend efforts, sql functions, and api generation. There was a lot of collaboration on each part of the project.
-- kris: api routing & functions
-- mat: queries, data scrapping
-- gui: Database data, gcp sql & compute engine