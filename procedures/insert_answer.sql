CREATE PROCEDURE insert_answer (id_anw INT,value_anw TINYINT, serie_itm INT, id_que SMALLINT)
BEGIN 
	DECLARE que_result INT DEFAULT 0;
BEGIN TRY
    SET que_result = (SELECT count(*) FROM item_questions iq WHERE iq.itm_serie = serie_itm AND iq.que_id = id_que);
	IF (que_result == 1)
    	INSERT INTO answers VALUES (anw_id,anw_value,itm_serie,que_id)
    ELSE
    	SELECT -99 AS pro_error
    END IF;
END TRY
BEGIN CATCH
	SELECT ERRORS
END CATCH
END