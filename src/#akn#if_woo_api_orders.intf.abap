INTERFACE /akn/if_woo_api_orders
  PUBLIC.
  TYPES _order_id TYPE i.
  TYPES: BEGIN OF _taxe,
           id                 TYPE i,
           rate_code          TYPE string,
           rate_id            TYPE string,
           label              TYPE string,
           compound           TYPE string,
           tax_total          TYPE string,
           shipping_tax_total TYPE string,
           meta_data          TYPE /akn/if_woo_api=>_meta_data_t,
         END OF _taxe.
  TYPES _taxes TYPE SORTED TABLE OF _taxe WITH UNIQUE KEY id.

  TYPES: BEGIN OF _line_item,
           id           TYPE i,                             " Item ID.READ-ONLY
           name         TYPE string,                        " Product name.
           product_id   TYPE i,                             " Product ID.
           variation_id TYPE i,                             " Variation ID, if applicable.
           quantity     TYPE i,                             " Quantity ordered.
           tax_class    TYPE string,                        " Slug of the tax class of product.
           subtotal     TYPE string,                        " Line subtotal (before discounts).
           subtotal_tax TYPE string,                        " Line subtotal tax (before discounts).READ-ONLY
           total        TYPE string,                        " Line total (after discounts).
           total_tax    TYPE string,                        " Line total tax (after discounts).READ-ONLY
           taxes        TYPE _taxes,                        " Line taxes. See Order - Taxes propertiesREAD-ONLY
           meta_data    TYPE /akn/if_woo_api=>_meta_data_t, " Meta data. See Order - Meta data properties
           sku          TYPE string,                        " Product SKU.READ-ONLY
           price        TYPE string,                        " Product price.READ-ONLY
         END OF _line_item,
         _line_items TYPE TABLE OF _line_item WITH EMPTY KEY.
  TYPES: BEGIN OF _order,
           id                   TYPE _order_id,
           parent_id            TYPE string,
           number               TYPE string,
           order_key            TYPE string,
           status               TYPE string,
           currency             TYPE string,
           date_created         TYPE string,
           date_modified        TYPE string,
           discount_total       TYPE string,
           discount_tax         TYPE string,
           shipping_total       TYPE string,
           cart_tax             TYPE string,
           total                TYPE string,
           total_tax            TYPE string,
           prices_include_tax   TYPE boolean,
           customer_id          TYPE i,
           customer_ip_address  TYPE string,
           customer_user_agent  TYPE string,
           customer_note        TYPE string,
           billing              TYPE /akn/if_woo_api_address=>billing,
           shipping             TYPE /akn/if_woo_api_address=>billing,
           payment_method       TYPE string,
           payment_method_title TYPE string,
           transaction_id       TYPE string,
           date_paid            TYPE string,
           date_paid_gmt        TYPE string,
           date_completed       TYPE string,
           date_completed_gmt   TYPE string,
           cart_hash            TYPE string,
           meta_data            TYPE /akn/if_woo_api=>_meta_data_t,
           line_items           TYPE _line_items,
           tax_lines            TYPE _taxes,
           " shipping_lines
           " fee_lines
           " coupon_lines
           " refunds
           set_paid             TYPE boolean,
         END OF _order,
         _orders TYPE TABLE OF _order WITH KEY id.

  TYPES: BEGIN OF _order_instance,
           id     TYPE _order_id,
           object TYPE REF TO /akn/if_woo_api_order,
         END OF _order_instance,
         _order_instances TYPE SORTED TABLE OF _order_instance WITH UNIQUE KEY id.

  METHODS get_list
    IMPORTING
      i_force_read    TYPE boolean OPTIONAL
      i_page          TYPE i       DEFAULT  1
      i_per_page      TYPE i       DEFAULT 10
    RETURNING
      VALUE(r_result) TYPE _orders.

  METHODS get
    IMPORTING
      i_id            TYPE _order_id
    RETURNING
      VALUE(r_result) TYPE REF TO /akn/if_woo_api_order.



ENDINTERFACE.
