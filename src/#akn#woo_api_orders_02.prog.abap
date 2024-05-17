REPORT /akn/woo_api_orders_02.

DATA order TYPE REF TO /akn/if_woo_api_order.

PARAMETERS p_id TYPE /akn/if_woo_api_orders=>_order_id DEFAULT '783'.
PARAMETERS st_curr TYPE c LENGTH 20 MODIF ID dsp.
SELECTION-SCREEN BEGIN OF BLOCK status WITH FRAME TITLE TEXT-st0.
PARAMETERS st_pend RADIOBUTTON GROUP stat DEFAULT 'X'.
PARAMETERS st_proc RADIOBUTTON GROUP stat.
PARAMETERS st_hold RADIOBUTTON GROUP stat.
PARAMETERS st_canc RADIOBUTTON GROUP stat.
SELECTION-SCREEN END OF BLOCK status.

INITIALIZATION.
  DATA(woo) = CAST /akn/if_woo_api( NEW /akn/cl_woo_api( ) ).

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'DSP'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN.
  DATA(orders) = woo->get_orders( ).

  order = orders->get( p_id ).
  st_curr = order->get_status( ).

START-OF-SELECTION.

  DATA(new_status) = order->update_status( COND #(
     WHEN st_pend = abap_true THEN /akn/if_woo_api_order=>c_order_status-pending
     WHEN st_proc = abap_true THEN /akn/if_woo_api_order=>c_order_status-processing
     WHEN st_hold = abap_true THEN /akn/if_woo_api_order=>c_order_status-onhold
     WHEN st_canc = abap_true THEN /akn/if_woo_api_order=>c_order_status-cancelled ) ).

  MESSAGE |new status: { new_status }| TYPE 'I'.
