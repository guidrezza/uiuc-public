DELIMITER //
CREATE TRIGGER RecordClick
BEFORE INSERT ON click_logs
FOR EACH ROW
BEGIN
    SET @recent_click_count = (
        SELECT COUNT(*) FROM click_logs
        WHERE (card_id = new.card_id) AND (ip_addr = new.ip_addr) AND TIMESTAMPDIFF(MINUTE, date_time, new.date_time) < 5
    );

    -- Trigger body cannot modify the same table that invoked the trigger
    IF @recent_click_count > 0 THEN
        -- UPDATE click_logs SET date_time = new.date_time WHERE (card_id = new.card_id) AND (ip_addr = new.ip_addr);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unique IP address cannot insert multiple timestamps on the same card in under 5 minutes';
    END IF;
END //
DELIMITER ;