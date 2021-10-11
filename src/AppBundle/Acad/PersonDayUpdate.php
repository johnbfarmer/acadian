<?php 

namespace AppBundle\Acad;

use AppBundle\Helper\QueryHelper;

class PersonDayUpdate extends BaseProcess
{
    protected
        $x;

    protected function execute()
    {
        $data = $this->parameters['data'];
        $col = $data['col'];
        \AppBundle\Helper\GenericHelper::log($data);
        $ts = date('Y:m:s H:i:s');
        $params = [
            $this->parameters['dt'],
            $data['student_course_id'],
            $data['val'],
        ];
        $sql = '
        INSERT INTO time_log
        (`date`, `student_course_id`, `' . $col . '`, `updated_at`, `created_at`)
        VALUES
        (?,?,?,NOW(),NOW())
        ON DUPLICATE KEY UPDATE
        `' . $col . '` = VALUES(`' . $col . '`),
        updated_at = VALUES(`updated_at`)
        ';

        $this->exec($sql, $params, true);
    }
}