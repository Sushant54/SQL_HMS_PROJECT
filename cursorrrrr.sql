[1:38 PM, 4/8/2022] Rachit Srm: DELIMITER $$
CREATE PROCEDURE createEmailList (
	INOUT emailList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE emailAddress varchar(100) DEFAULT "";

	-- declare cursor for employee email
	DEClARE curEmail 
		CURSOR FOR 
			SELECT emp_email_address FROM employees;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curEmail;

	getEmail: LOOP
		FETCH curEmail INTO emailAddress;
		IF finished = 1 THEN 
			LEAVE getEmail;
		END IF;
		-- build email list
		SET emailList = CONCAT(emailAddress,";",emailList);
	END LOOP getEmail;
	CLOSE curEmail;

END$$
DELIMITER ;
[1:47 PM, 4/8/2022] Rachit Srm: SET @emailList = "";
CALL createEmailList(@emailList);
SELECT @emailList;
[1:48 PM, 4/8/2022] Rachit Srm: DELIMITER //

CREATE TRIGGER bookings_after_delete 
AFTER DELETE ON bookings
FOR EACH ROW

BEGIN
INSERT INTO Bookings_Audit VALUES
(NULL, OLD.booking_id, OLD.booking_date, OLD.duration_of_stay, OLD.`check_in_date`, OLD.`check_out_date`, OLD.`booking_payment_type`, OLD.`total_rooms_booked`, OLD.`hotel_hotel_id`, OLD.`guests_guest_id`, OLD.`employees_emp_id`, OLD.`total_amount`,"DELETED", NOW());
END//

DELIMITER ;
