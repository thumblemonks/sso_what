# Sso What

Sso What enables your Rails app to function well with sub-domains solely in the context of managing cookies. Sso What has to do two things (which makes us angry since it should only be one):

1. Support a dynamic domain when setting the session-domain for session cookies
2. Support a cookie domain that works across sub-domains for all cookies other than a session cookie

### Session Cookies

Sso What is used to generate a session domain for single sign-on which works regardless of sub-domains and different hosts in different environments. So. If you have two servers, `kill.for.thrills.hypo.luxa` and `thrill.olympics.hypo.luxa`, the session domain would resolve to `hypo.luxa`.  

If your staging environment uses `kill.for.thrills.alien.jourgensen` it will automatically use `alien.jourgensen` without further configuration.

To enable this feature set the session options on `ActionController` using the following line in your environment file:

    config.action_controller.session = {:session_domain  => :base_host}

### All other cookies

Sso What will force (for now since it's not configurable) all cookies that you set without an explicit domain to work across sub-domains. For example, if the domain your app is serving is `foo.example.com` and you set a cookie named `bar` but don't provide a domain, Sso What will kick in and set the domain to `.example.com`. Without Sso What, the domain would be `foo.example.com`.

If you provide an explicit domain with your cookie, Sso What just watches everything go by. It may cry a little, though :(

# Requirements

Shoulda and Mocha are required to run the tests.

## License

Copyright (c) 2008 {Centro}[www.centro.net], released under the MIT license.

Authored by:

    {Gabriel Gironda}[gabriel.gironda@gmail.com]
    {Josh Davison}[josh.davison@centro.net]
    {Justin Knowlden}[gus@gusg.us]