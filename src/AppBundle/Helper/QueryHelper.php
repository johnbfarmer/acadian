<?php

namespace AppBundle\Helper;

class QueryHelper
{
	public static 
		$connection;

	public function __construct($connection)
	{
		self::$connection = $connection;
	}

	public static function getConnection()
	{
		return self::$connection;
	}

    public static function getTableName($lookupName, $tick = true)
    {
        $databases = ConfigHelper::get('databases');

        foreach($databases AS $db_key => $database) {
            $db_name = $database['name'];
            $tables = $database['tables'];
            
            foreach($tables AS $key => $table_name) {
                if ($key == $lookupName) {
                    if($tick) {
                        $table_name = '`' . $table_name . '`';
                    }

                    return $table_name;
                }
            }
        }
         
        throw new \Exception('Invalid lookup name for table name ' . $lookupName);
    }

	public static function exec($sql, $params = [], $log = false, $throwException = false)
    {
        if ($log) {
            GenericHelper::log($sql);
            GenericHelper::log($params);
        }
        $success = false;
        try {
            $stmt = self::$connection->prepare($sql);
            $success = $stmt->execute($params);
            if (!$success) {
                $error = $stmt->errorInfo();
                // '00000' means all is well
                if ($error[0] !== '00000') {
                    GenericHelper::log($error[2]);
                    if ($throwException) {
                        throw new \PDOException($error[2]);
                    }
                }
            }
        } catch (\Exception $e) {
            GenericHelper::log($e->getMessage());
            if ($throwException) {
                throw $e;
            }
        }

        return $stmt;
    }

    public static function fetch($sql, $params = [], $log = false)
    {
        $stmt = self::exec($sql, $params, $log);
        $record = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $record;
    }

    public static function fetchAll($sql, $params = [], $log = false)
    {
        $stmt = self::exec($sql, $params, $log);
        $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $records;
    }

    public static function lastInsertId($connection = null)
    {
        $connection = $connection ?: self::$connection;
        return $connection->lastInsertId();
    }
    
    public static function dropTableIfExists($tables, $log = false)
    {
        if (!empty($tables)) {
            if (is_array($tables)) {
                $tables = implode(',', $tables);
            }

            $query = '
        DROP TABLE IF EXISTS ' . $tables . ';';

            return self::exec($query, [], $log);
        }

        return true;
    }
    
    public static function tableExists($table)
    {
        $query = '
        SHOW TABLES LIKE "' . $table . '"';

        $result = self::fetchAll($query, [], false);

        return !empty($result);
    }

	public function onKernelRequest($event)
	{
		return;
	}

	public function onConsoleCommand($event)
	{
		return;
	}
}
