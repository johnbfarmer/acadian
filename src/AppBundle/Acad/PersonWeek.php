<?php 

namespace AppBundle\Acad;

use AppBundle\Helper\QueryHelper;
use AppBundle\Helper\Tablifier;

class PersonWeek extends BaseProcess
{
    protected function execute()
    {
        $sql = '
        SELECT DATE_FORMAT(`date`, "%b %e, %Y") AS `date`, S.name AS hide_subject, IFNULL(L.minutes, 0) AS minutes, 
        IFNULL(L.notes, "") AS notes, SC.id AS student_course_id, 0 as is_total, `date` AS iso_date
        FROM student_course SC
        INNER JOIN subject_block SB ON SB.id = SC.subject_block_id
        INNER JOIN subjects S ON S.id = SB.subject_id
        INNER JOIN time_log L ON L.student_course_id = SC.id
        WHERE SC.student_id = ? AND L.date BETWEEN ? AND DATE_ADD(?, INTERVAL 6 DAY)
        UNION
        SELECT UPPER(CONCAT(S.name, " total")) AS `date`, S.name AS hide_subject, SUM(IFNULL(L.minutes, 0)) AS minutes, 
        "" AS notes, SC.id AS student_course_id, 1 as is_total, `date` AS iso_date
        FROM student_course SC
        INNER JOIN subject_block SB ON SB.id = SC.subject_block_id
        INNER JOIN subjects S ON S.id = SB.subject_id
        INNER JOIN time_log L ON L.student_course_id = SC.id
        WHERE SC.student_id = ? AND L.date BETWEEN ? AND DATE_ADD(?, INTERVAL 6 DAY)
        GROUP BY student_course_id
        ORDER BY `hide_subject`, is_total DESC, `iso_date`;';

        $this->data = Tablifier::tablify($this->fetchAll($sql, [
            $this->parameters['pid'], $this->parameters['dt'], $this->parameters['dt'],
            $this->parameters['pid'], $this->parameters['dt'], $this->parameters['dt'],
        ], false))->getTable();
    }
}