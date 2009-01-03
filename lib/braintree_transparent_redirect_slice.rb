if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-slices', :immediate => true
  Merb::Plugins.add_rakefiles "braintree_transparent_redirect_slice/merbtasks", "braintree_transparent_redirect_slice/slicetasks", "braintree_transparent_redirect_slice/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)

  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :braintree_transparent_redirect_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:braintree_transparent_redirect_slice][:layout] ||= :braintree_transparent_redirect_slice

  # All Slice code is expected to be namespaced inside a module
  module BraintreeTransparentRedirectSlice
    # Slice metadata
    self.description = "BraintreeTransparentRedirectSlice is like going to heaven and finding god smoking crack!"
    self.version = "0.0.1"
    self.author = "Corey Donohoe at Engine Yard"

    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
      BRAINTREE = { }
    end

    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
      bt = YAML.load_file(Merb.root / 'config' / 'braintree.yml')
      if bt[Merb.env]
        bt[Merb.env].each do |k,v|
          BRAINTREE[k.to_sym] = v
        end
      end
    end

    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end

    # Deactivation hook - triggered by Merb::Slices.deactivate(BraintreeTransparentRedirectSlice)
    def self.deactivate
    end

    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :braintree_transparent_redirect_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.match('/index(.:format)').to(:controller => 'main', :action => 'index').name(:index)
      # the slice is mounted at /braintree_transparent_redirect_slice - note that it comes before default_routes
      scope.match('/').to(:controller => 'main', :action => 'index').name(:home)
      # enable slice-level default routes by default
      scope.default_routes
    end
  end

  # Setup the slice layout for BraintreeTransparentRedirectSlice
  #
  # Use BraintreeTransparentRedirectSlice.push_path and BraintreeTransparentRedirectSlice.push_app_path
  # to set paths to braintree_transparent_redirect_slice-level and app-level paths. Example:
  #
  # BraintreeTransparentRedirectSlice.push_path(:application, BraintreeTransparentRedirectSlice.root)
  # BraintreeTransparentRedirectSlice.push_app_path(:application, Merb.root / 'slices' / 'braintree_transparent_redirect_slice')
  # ...
  #
  # Any component path that hasn't been set will default to BraintreeTransparentRedirectSlice.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  BraintreeTransparentRedirectSlice.setup_default_structure!
  # Add dependencies for other BraintreeTransparentRedirectSlice classes below. Example:
  # dependency "braintree_transparent_redirect_slice/other"
end
