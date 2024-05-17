CLASS /akn/cl_woo_api_call DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS get_response
      IMPORTING i_part          TYPE string
      RETURNING VALUE(r_result) TYPE string.
    CLASS-METHODS set_request
      IMPORTING i_part          TYPE string
                i_json_data     TYPE string
      RETURNING VALUE(r_result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS get_client
      IMPORTING
        i_part          TYPE string
      RETURNING
        VALUE(r_client) TYPE REF TO if_http_client.
    CLASS-METHODS send_and_receive
      IMPORTING
        i_client        TYPE REF TO if_http_client
      RETURNING
        VALUE(r_result) TYPE string.
ENDCLASS.



CLASS /akn/cl_woo_api_call IMPLEMENTATION.
  METHOD get_response.

    DATA(client) = get_client( i_part ).
    r_result = send_and_receive( client ).

  ENDMETHOD.


  METHOD get_client.

    "Create HTTP destination in SM59
    "see https://github.com/abapGit/abapGit/issues/1841
    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = 'APPKNIGHT WOOCOMMERCE'
      IMPORTING
        client                   = r_client
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6 ).
    IF sy-subrc = 0.
      cl_http_utility=>set_request_uri(
          request    = r_client->request
          uri        = i_part ).
    ENDIF.

*    cl_http_client=>create_by_url(
*      EXPORTING
*        url           = url
*        ssl_id        = 'ANONYM'
*      IMPORTING
*        client        =      r_client  ).
*
** enter username and password for proxy authentication if needed
*    r_client->authenticate(
*      proxy_authentication = abap_false
*      username             = 'your_username'
*      password             = 'your_password' ).

  ENDMETHOD.

  METHOD set_request.

    DATA(client) = get_client( i_part ).

    client->request->set_method( if_http_request=>co_request_method_post ).
    client->request->set_content_type( content_type = 'application/json' ).
    client->request->set_cdata( i_json_data ).
    r_result = send_and_receive( client ).
  ENDMETHOD.


  METHOD send_and_receive.

    i_client->send( ).
    i_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4 ).
    IF sy-subrc <> 0.
      r_result = |error receive: { sy-subrc }|.
      i_client->get_last_error(
        IMPORTING
          message = DATA(error_message) ).
    ELSE.
      i_client->response->get_status(
          IMPORTING
            code = DATA(status_code) ).
      IF status_code = 200.
        r_result = i_client->response->get_cdata( ).
      ELSE.
        r_result = |error. status code: { status_code }|.
      ENDIF.
    ENDIF.

    i_client->close( ).

  ENDMETHOD.

ENDCLASS.
