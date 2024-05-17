CLASS /akn/cl_woo_api_orders DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /akn/if_woo_api_orders .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA orders TYPE /akn/if_woo_api_orders=>_orders.
    DATA order_instances TYPE /akn/if_woo_api_orders=>_order_instances.

ENDCLASS.



CLASS /akn/cl_woo_api_orders IMPLEMENTATION.
  METHOD /akn/if_woo_api_orders~get_list.

    IF i_force_read <> space OR orders IS INITIAL.
      DATA(json_response) = /akn/cl_woo_api_call=>get_response( |orders?page={ i_page }&per_page={ i_per_page }| ).
      DATA(parser) = NEW /ui2/cl_json( ).
      parser->deserialize(
        EXPORTING
          json             = json_response
        CHANGING
          data             = orders ).
    ENDIF.
    r_result = orders.
  ENDMETHOD.

  METHOD /akn/if_woo_api_orders~get.

    IF line_exists( order_instances[ id = i_id ] ).
      r_result = order_instances[ id = i_id ]-object.
    ELSE.
      r_result = NEW /akn/cl_woo_api_order( i_id ).
      INSERT VALUE #( id     = i_id
                      object = r_result ) INTO TABLE order_instances.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
