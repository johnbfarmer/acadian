<?php

namespace AppBundle\Helper;

class Tablifier
{
    protected
        $data = [],
        $cols = [],
        $rows = [],
        $total = [],
        $colConfig = [],
        $hiddenCols = ['is_total', 'id', 'student_course_id', 'hide_subject'],
        $table = [];

    public function __construct($data, $limitCols = [], $total = [])
    {
        $this->data = $data;
        $this->total = $total;
        $this->colConfig = [];
        $this->getLimitedCols($limitCols);
    }

    protected function execute() 
    {
        $cols = $this->getCols();
        $rows = $this->getRows();
        GenericHelper::log($this->rows);
        $this->table = [
            'table' => [
                'columns' => $this->cols,
                'rows' => $this->rows,
                'total' => $this->total,
            ]
        ];
        GenericHelper::log($this->table);
    }

    protected function getCols()
    {
        $cols = [];

        if (!empty($this->data)) {
            foreach (current($this->data) as $uid => $item) {
                $cols[$uid] = [
                    'uid' => $uid,
                    'label' => $uid,
                    'visible' => !in_array($uid, $this->hiddenCols),
                ];
                $this->cols[] = $cols[$uid];
            }
        }
    }

    protected function getRows()
    {
        GenericHelper::log($this->data);
        if (!empty($this->data)) {
            foreach ($this->data as $rows) {
                $row = [];
                foreach ($rows as $uid => $item) {
                    $row[$uid] = $item;
                }
                $this->rows[] = $row;
            }
        }
    } 

    public static function tablify($vars, $limitCols = [], $total = []) 
    {
        $className = get_called_class();
        $class = new $className($vars, $limitCols, $total);
        $class->execute();
        return $class;
    }

    protected function getLimitedCols($userCols)
    {
        if (!empty($userCols)) {
            $dimensions = ['date', 'iso_date', 'id'];
            $userCols = array_unique(array_merge($dimensions, $userCols));
            $tempCols = [];
            foreach ($this->colConfig as $uid => $item) {
                if (in_array($uid, $userCols)) {
                    $tempCols[$uid] = $item;
                }
            }

            $this->colConfig = $tempCols;
        }
    }

    public function getTable() 
    {
        return $this->table;
    }
}
