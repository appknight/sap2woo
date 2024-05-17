INTERFACE /akn/if_woo_api_order
  PUBLIC.

  TYPES _order_status TYPE string.

  CONSTANTS: BEGIN OF c_order_status,
               pending    TYPE _order_status VALUE `pending`,
               processing TYPE _order_status VALUE `processing`,
               onhold     TYPE _order_status VALUE `on-hold`,
               completed  TYPE _order_status VALUE `completed`,
               cancelled  TYPE _order_status VALUE `cancelled`,
               refunded   TYPE _order_status VALUE `refunded`,
               failed     TYPE _order_status VALUE `failed`,
               trash      TYPE _order_status VALUE `trash`,
             END OF c_order_status.
  METHODS read.

  METHODS get
    RETURNING
      VALUE(r_result) TYPE /akn/if_woo_api_orders=>_order.

  METHODS get_status
    RETURNING
      VALUE(r_result) TYPE _order_status.

  METHODS update_status
    IMPORTING
      i_status        TYPE _order_status
    RETURNING
      VALUE(r_result) TYPE string.
ENDINTERFACE.
