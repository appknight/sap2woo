INTERFACE /akn/if_woo_api_address
  PUBLIC.
  TYPES: BEGIN OF billing,
           first_name TYPE string, " First name.
           last_name  TYPE string, " Last name.
           company    TYPE string, " Company name.
           address_1  TYPE string, " Address line 1
           address_2  TYPE string, " Address line 2
           city       TYPE string, " City name.
           state      TYPE string, " ISO code or name of the state, province or district.
           postcode   TYPE string, " Postal code.
           country    TYPE string, " ISO code of the country.
           email      TYPE string, " Email address.
           phone      TYPE string, " Phone number.
         END OF billing.
  TYPES: BEGIN OF shipping,
           first_name TYPE string, " First name.
           last_name  TYPE string, " Last name.
           company    TYPE string, " Company name.
           address_1  TYPE string, " Address line 1
           address_2  TYPE string, " Address line 2
           city       TYPE string, " City name.
           state      TYPE string, " ISO code or name of the state, province or district.
           postcode   TYPE string, " Postal code.
           country    TYPE string, " ISO code of the country.
         END OF shipping.

ENDINTERFACE.
