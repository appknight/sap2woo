CLASS /akn/cl_woo_api_customers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /akn/if_woo_api_customers .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA customers TYPE /akn/if_woo_api_customers=>_customers.
ENDCLASS.



CLASS /akn/cl_woo_api_customers IMPLEMENTATION.
  METHOD /akn/if_woo_api_customers~get_list.

    IF i_force_read <> space OR customers IS INITIAL.
      DATA(json_response) = /akn/cl_woo_api_call=>get_response( `customers` ).
      DATA(parser) = NEW /ui2/cl_json( ).
      parser->deserialize(
        EXPORTING
          json             = json_response
        CHANGING
          data             = customers ).
    ENDIF.
    r_result = customers.
  ENDMETHOD.

  METHOD /akn/if_woo_api_customers~get.
    IF customers IS INITIAL.
      DATA(json_response) = /akn/cl_woo_api_call=>get_response( |customers/{ i_id }| ).
      DATA(parser) = NEW /ui2/cl_json( ).
      parser->deserialize(
        EXPORTING
          json             = json_response
        CHANGING
          data             = r_result ).
    ELSE.
      r_result = VALUE #( customers[ id = i_id ] DEFAULT value #( ) ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
