INTERFACE /akn/if_woo_api
  PUBLIC.

  " https://woocommerce.github.io/woocommerce-rest-api-docs/#customer-properties

  TYPES: BEGIN OF _meta_data,
           id    TYPE i,
           key   TYPE string,
           value TYPE string,
         END OF _meta_data,
         _meta_data_t TYPE SORTED TABLE OF _meta_data WITH UNIQUE KEY id.

  " example: 2017-03-22T16:28:02
  TYPES: BEGIN OF _iso_Date,
           year   TYPE n LENGTH 4,
           d1     TYPE c LENGTH 1,
           month  TYPE n LENGTH 2,
           d2     TYPE c LENGTH 1,
           day    TYPE n LENGTH 2,
           t      TYPE c LENGTH 1,
           hour   TYPE n LENGTH 2,
           c1     TYPE c LENGTH 1,
           minute TYPE n LENGTH 2,
           c2     TYPE c LENGTH 1,
           second TYPE n LENGTH 2,
         END OF _iso_date.

  METHODS get_customers
    RETURNING
      VALUE(r_result) TYPE REF TO /akn/if_woo_api_customers.

  METHODS get_orders
    RETURNING
      VALUE(r_result) TYPE REF TO /akn/if_woo_api_orders.

  METHODS get_products
    RETURNING
      VALUE(r_result) TYPE REF TO /akn/if_woo_api_products.
ENDINTERFACE.
