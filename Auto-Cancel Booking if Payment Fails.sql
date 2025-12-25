DELIMITER //

CREATE TRIGGER auto_cancel_booking
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Failed' THEN
        UPDATE Bookings
        SET booking_status='Cancelled'
        WHERE booking_id = NEW.booking_id;
    END IF;
END //

DELIMITER ;
