INTERFACE /akn/if_woo_api_customers
  PUBLIC.
  TYPES customer_id TYPE i.
  TYPES: BEGIN OF _customer,
           id           TYPE customer_id,
           date_created TYPE /akn/if_woo_api=>_iso_Date,
           email        TYPE string,
           first_name   TYPE string,
           last_name    TYPE string,
           username     TYPE string,
           billing      TYPE /akn/if_woo_api_address=>billing,
           shipping     TYPE /akn/if_woo_api_address=>shipping,
         END OF _customer,
         _customers TYPE SORTED TABLE OF _customer WITH UNIQUE KEY id.

  METHODS get_list
    IMPORTING
      i_force_read    TYPE boolean OPTIONAL
    RETURNING
      VALUE(r_result) TYPE _customers.

  METHODS get
    IMPORTING
      i_id            TYPE customer_id
    RETURNING
      VALUE(r_result) TYPE _customer.

ENDINTERFACE.
