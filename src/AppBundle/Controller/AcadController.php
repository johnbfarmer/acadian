<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

use AppBundle\Helper\GenericHelper;
use AppBundle\Helper\Tablifier;
use AppBundle\Acad\PersonDay;
use AppBundle\Acad\PersonWeek;
use AppBundle\Acad\PersonMonth;
use AppBundle\Acad\PersonDayUpdate;

/**
 * Vitalstat controller.
 *
 * @Route("acad")
 */
class AcadController extends Controller
{
    /**
     * @Route("/pd/{pid}/{dt}", name="acad_person_day")
     * @Method("GET")
     */
    public function personDayAction(SessionInterface $session, $pid, $dt)
    {
        if ($dt == 0) {
            $dt = date('Ymd');
        }

        return new JsonResponse(PersonDay::autoExecute(['pid' => $pid, 'dt' => $dt])->getData());
    }

    /**
     * @Route("/wk/{pid}/{dt}", name="acad_person_week")
     * @Method("GET")
     */
    public function personWeekAction(SessionInterface $session, $pid, $dt)
    {
        if ($dt == 0) {
            $dt = date('Ymd');
        }

        return new JsonResponse(PersonWeek::autoExecute(['pid' => $pid, 'dt' => $dt])->getData());
    }

    /**
     * @Route("/month/{pid}/{dt}", name="acad_person_month")
     * @Method("GET")
     */
    public function personMonthAction(SessionInterface $session, $pid, $dt)
    {
        if ($dt == 0) {
            $dt = date('Ymd');
        }

        return new JsonResponse(PersonMonth::autoExecute(['pid' => $pid, 'dt' => $dt])->getData());
    }

    /**
     * @Route("/pd-update/{pid}/{dt}", name="acad_person_day_update")
     * @Method("POST")
     */
    public function personDayUpdateAction(Request $request, $pid, $dt)
    {
        if ($dt == 0) {
            $dt = date('Ymd');
        }
        $parameters = json_decode(file_get_contents('php://input'), true);
        \AppBundle\Helper\GenericHelper::log($parameters);
        return new JsonResponse(PersonDayUpdate::autoExecute(['pid' => $pid, 'dt' => $dt, 'data' => $parameters])->getData());
    }
}
