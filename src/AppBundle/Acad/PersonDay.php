<?php 

namespace AppBundle\Acad;

use AppBundle\Helper\QueryHelper;
use AppBundle\Helper\Tablifier;

class PersonDay extends BaseProcess
{
    protected function execute()
    {
        $sql = '
        SELECT S.name AS subject, IFNULL(L.minutes, 0) AS minutes,
        -- IFNULL(L.points, 0) AS points, 
        IFNULL(L.notes, "") AS notes, SC.id AS student_course_id
        FROM student_course SC
        INNER JOIN subject_block SB ON SB.id = SC.subject_block_id
        INNER JOIN subjects S ON S.id = SB.subject_id
        LEFT JOIN time_log L ON L.student_course_id = SC.id AND L.date = ?
        WHERE SC.student_id = ? AND (L.date = ? OR L.date IS NULL)
        ORDER BY subject;';

        $this->data = Tablifier::tablify($this->fetchAll($sql, [$this->parameters['dt'], $this->parameters['pid'], $this->parameters['dt']]))->getTable();
    }
}