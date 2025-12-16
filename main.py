import mysql.connector
import logging, time


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    logger = logging.getLogger(__name__)
    try:
        cnx = mysql.connector.connect(
            host="db",
            port=3306,
            user="barcikwhyme",
            password="1234",
            database="LAB3_TEST"
        )
        logger.debug("Connected")
        cursor = cnx.cursor()

        cursor.execute("CREATE TABLE IF NOT EXISTS test (id INT PRIMARY KEY, name VARCHAR(100))")
        cursor.execute("INSERT INTO test (id, name) VALUES (1, \"yes\"), (2, \"no\")")
        cnx.commit()
        
        time.sleep(5)
        cursor.execute("SELECT * FROM test")
        logger.debug(cursor.fetchall())
        cnx.close()
    except Exception as e:
        logger.debug(e)
        logger.debug("Not Success")