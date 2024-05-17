CLASS /akn/cl_woo_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /akn/if_woo_api .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA customers TYPE REF TO /akn/if_woo_api_customers.
    DATA orders TYPE REF TO /akn/if_woo_api_orders.
    DATA products TYPE REF TO /akn/if_woo_api_products.
ENDCLASS.



CLASS /akn/cl_woo_api IMPLEMENTATION.
  METHOD /akn/if_woo_api~get_customers.
    r_result = NEW /akn/cl_woo_api_customers( ).
  ENDMETHOD.

  METHOD /akn/if_woo_api~get_orders.
    r_result = NEW /akn/cl_woo_api_orders( ).
  ENDMETHOD.

  METHOD /akn/if_woo_api~get_products.

  ENDMETHOD.

ENDCLASS.
