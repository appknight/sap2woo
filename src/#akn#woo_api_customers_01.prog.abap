REPORT /akn/woo_api_customers_01.


PARAMETERS: p_id TYPE i DEFAULT '17'.

START-OF-SELECTION.
  PERFORM run.

FORM run.
  DATA(woo) = CAST /akn/if_woo_api( NEW /akn/cl_woo_api( ) ).
  DATA(customers) = woo->get_customers( ).

  IF p_id IS INITIAL.

    LOOP AT customers->get_list( ) INTO DATA(customer).
      PERFORM print_customer USING customer.
    ENDLOOP.

  ELSE.
    customer = customers->get( p_id ).
    PERFORM print_customer USING customer.
  ENDIF.

ENDFORM.

FORM print_customer USING i_customer TYPE /akn/if_woo_api_customers=>_customer.
  WRITE:
    /1 i_customer-id,
    12 i_customer-email,
    50 i_customer-first_name,
    70 i_customer-last_name,
    90 i_customer-date_created,
   110 i_customer-billing-city,
   130 i_customer-shipping-city.
ENDFORM.
