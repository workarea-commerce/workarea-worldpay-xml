Workarea Worldpay Xml
================================================================================

Worldpay Xml Payment Processor plugin for the Workarea platform.

Installation
--------------------------------------------------------------------------------

Add the following block to your gem file:

    # ...
    gem 'workarea-worldpay-xml', source: 'https://gems.weblinc.com'
    # ...

Or use a source block:

    # ...
    source 'https://gems.weblinc.com' do
      gem 'workarea-worldpay-xml'
    end
    # ...

Update your application's bundle.

    cd path/to/application
    bundle


Add the following to your secrets file:

    # ...
    worldpay:
      login: MERCHANTCODEHERE
      password: XMLPASSWORD
      test: true
    # ...


*By default tokenzization is not enabled in both live and sandbox account. Be sure to request that tokenzation
is enabled after installing the plugin.*

Documentation and Testing
--------------------------------------------------------------------------------

Worldpay does not issue freestanding sandbox accounts for testing. An account must be provisioned through
a Worldpay account manager.

Documentation for the Worldpay xml gateway can be found at [http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/home.htm](http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/home.htm)

A list of test credit cards and testing values can be found at [http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/reference/testvalues.htm](http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/reference/testvalues.htm)


Workarea Platform Documentation
--------------------------------------------------------------------------------

See [http://developer.weblinc.com](http://developer.weblinc.com) for Workarea platform documentation.

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright WebLinc 2018. All rights reserved.

For licensing, contact sales@workarea.com.
