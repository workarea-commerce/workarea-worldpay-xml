Workarea Worldpay XML
================================================================================

Worldpay Xml Payment Processor plugin for the Workarea platform.

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-worldpay_xml'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Add the following to your `config/secrets.yml` file:

    # ...
    worldpay:
      login: MERCHANTCODEHERE
      password: XMLPASSWORD
      test: true
    # ...


*By default tokenzization is not enabled in both live and sandbox account. Be sure to request that tokenzation is enabled after installing the plugin.*

Documentation and Testing
--------------------------------------------------------------------------------

Worldpay does not issue freestanding sandbox accounts for testing. An account must be provisioned through a Worldpay account manager.

Documentation for the Worldpay xml gateway can be found at [http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/home.htm](http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/home.htm)

A list of test credit cards and testing values can be found at [http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/reference/testvalues.htm](http://support.worldpay.com/support/kb/gg/corporate-gateway-guide/content/reference/testvalues.htm)


Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Worldpay XML is released under the [Business Software License](LICENSE)
