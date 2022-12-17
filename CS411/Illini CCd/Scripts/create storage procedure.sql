DROP PROCEDURE GetCardRecommendation;
DELIMITER //
CREATE PROCEDURE GetCardRecommendation (
    IN vend_name_filter VARCHAR(256),
    IN vend_type_filter VARCHAR(256),
    IN credit_score_min_filter INT,
    IN credit_limit_min_filter INT,
    IN annual_fee_max_filter INT,
    IN payment_processor_filter VARCHAR(256)
)
BEGIN

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;
    DECLARE card_id_var INT;
    DECLARE min_rec_credit_var INT;
    DECLARE credit_limit_var REAL;
    DECLARE annual_fee_var REAL;
    DECLARE processor_name_var VARCHAR(255);
    DECLARE cardcur CURSOR FOR (
        SELECT card_id, min_rec_credit, credit_limit, annual_fee, processor_name FROM credit_cards 
        NATURAL JOIN (SELECT processor_id, processor_name FROM payment_processors) a
    );
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;


    DROP TEMPORARY TABLE IF EXISTS creditcardrec;
    CREATE TEMPORARY TABLE creditcardrec AS (
        SELECT * FROM credit_cards NATURAL JOIN (SELECT processor_id, processor_name FROM payment_processors) a
    );
    
    SELECT COUNT(*) FROM creditcardrec;

    OPEN cardcur;

    cloop: LOOP
        FETCH cardcur INTO card_id_var, min_rec_credit_var, credit_limit_var, annual_fee_var, processor_name_var; 
        
        IF (exit_loop) THEN
            LEAVE cloop;
        END IF;

        IF (min_rec_credit_var <= credit_score_min_filter) AND (credit_score_min_filter IS NOT NULL) THEN
            DELETE FROM creditcardrec WHERE card_id = card_id_var;
        ELSEIF (credit_limit_var <= credit_limit_min_filter) AND (credit_limit_min_filter IS NOT NULL) THEN 
            DELETE FROM creditcardrec WHERE card_id = card_id_var;
        ELSEIF (annual_fee_var <= annual_fee_max_filter) AND (annual_fee_max_filter IS NOT NULL) THEN
            DELETE FROM creditcardrec WHERE card_id = card_id_var;
        ELSEIF (payment_processor_filter NOT LIKE CONCAT('%', processor_name_var, '%')) AND (payment_processor_filter IS NOT NULL) THEN
            DELETE FROM creditcardrec WHERE card_id = card_id_var;
        END IF;
        
        -- DELETE FROM creditcardrec AS a WHERE a.card_id = card_id;
        
    END LOOP cloop;

    CLOSE cardcur;

    SELECT COUNT(*) FROM creditcardrec;

    DROP TEMPORARY TABLE IF EXISTS vendorsub;
    CREATE TEMPORARY TABLE vendorsub AS (
        SELECT cc1.card_id, COUNT(pv1.vend_id) AS vendor_requirements_counts
        FROM credit_cards cc1
        NATURAL JOIN offers o1 NATURAL JOIN preferred_vendors pv1
        WHERE (FIND_IN_SET(pv1.vend_type, @vend_type_filter) OR FIND_IN_SET(pv1.vend_name, @vend_name_filter))
        GROUP BY cc1.card_id
    );

    DROP TEMPORARY TABLE IF EXISTS ratingsub;
    CREATE TEMPORARY TABLE ratingsub AS (
        SELECT cc4.card_id, AVG(cr.rating) AS average_rating
        FROM credit_cards cc4
        NATURAL JOIN card_ratings cr
        GROUP BY cc4.card_id
    );

    SELECT cc.card_name FROM creditcardrec cc
    LEFT JOIN vendorsub vs ON cc.card_id = vs.card_id
    LEFT JOIN ratingsub rs ON cc.card_id = rs.card_id
    ORDER BY vendor_requirements_counts DESC, average_rating DESC
    LIMIT 10;

END //
DELIMITER ;