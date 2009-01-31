# SSo What

Sso What is used to generate a session domain for single sign-on which works regardless of sub-domains and different hosts in different environments. So. If you have two servers, `kill.for.thrills.hypo.luxa` and `thrill.olympics.hypo.luxa`, the session domain would resolve to `hypo.luxa`.  

If your staging environment uses `kill.for.thrills.alien.jourgensen` it will automatically use 'alien.jourgensen' without further configuration. 

To enable this feature set the session options on `ActionController` using the following line in your environment file:

    config.action_controller.session = {:session_domain  => :base_host}

# Requirements

Shoulda and Mocha are required to run the tests.

## License

Copyright (c) 2008 {Centro}[www.centro.net], released under the MIT license.

Authored by:

    {Gabriel Gironda}[gabriel.gironda@gmail.com]
    {Josh Davison}[josh.davison@centro.net]
    {Justin Knowlden}[gus@gusg.us]