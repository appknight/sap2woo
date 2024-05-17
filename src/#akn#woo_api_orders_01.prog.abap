REPORT /akn/woo_api_orders_01.


PARAMETERS: p_id TYPE /akn/if_woo_api_orders=>_order_id DEFAULT '783'.

START-OF-SELECTION.
  PERFORM run.

FORM run.
  DATA(woo) = CAST /akn/if_woo_api( NEW /akn/cl_woo_api( ) ).
  DATA(orders) = woo->get_orders( ).

  IF p_id IS INITIAL.

    LOOP AT orders->get_list( i_per_page = 20 ) INTO DATA(order).
      PERFORM print USING order.

    ENDLOOP.

  ELSE.
    order = orders->get( p_id )->get( ).
    PERFORM print USING order.
  ENDIF.

ENDFORM.

FORM print USING i_order TYPE /akn/if_woo_api_orders=>_order.

  WRITE:
    /1 i_order-id,
    12 i_order-number,
    30 i_order-order_key,
    55 i_order-status,
    90 i_order-date_created,
   110 i_order-total,
   130 i_order-currency.

ENDFORM.
