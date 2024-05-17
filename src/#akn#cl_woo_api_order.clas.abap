CLASS /akn/cl_woo_api_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES /akn/if_woo_api_order .
    METHODS constructor
      IMPORTING
        i_order_id TYPE /akn/if_woo_api_orders=>_order_id.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA order_id TYPE /akn/if_woo_api_orders=>_order_id.
    DATA order    TYPE /akn/if_woo_api_orders=>_order.
    DATA data_read TYPE boolean.
ENDCLASS.



CLASS /akn/cl_woo_api_order IMPLEMENTATION.

  METHOD constructor.

    me->order_id = i_order_id.

  ENDMETHOD.
  METHOD /akn/if_woo_api_order~get_status.
    IF data_read IS INITIAL.
      /akn/if_woo_api_order~read( ).
    ENDIF.

    r_result = order-status.
  ENDMETHOD.

  METHOD /akn/if_woo_api_order~update_status.

    r_result = /akn/cl_woo_api_call=>set_request(
         i_part      = |orders/{ order_id }|
         i_json_data = |\{  "status": "{ i_status }" \}|  ).

    DATA(parser) = NEW /ui2/cl_json( ).
    parser->deserialize( EXPORTING json = r_result
                         CHANGING  data = order ).
    r_result = order-status.

  ENDMETHOD.

  METHOD /akn/if_woo_api_order~read.

    DATA(json_response) = /akn/cl_woo_api_call=>get_response(
                              |orders/{ order_id }| ).
    DATA(parser) = NEW /ui2/cl_json( ).
    parser->deserialize( EXPORTING json = json_response
                         CHANGING  data = order ).
    data_read = abap_true.
  ENDMETHOD.

  METHOD /akn/if_woo_api_order~get.
    IF data_read IS INITIAL.
      /akn/if_woo_api_order~read( ).
    ENDIF.
    r_result = order.
  ENDMETHOD.

ENDCLASS.
