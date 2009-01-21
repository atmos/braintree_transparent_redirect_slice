# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{braintree_transparent_redirect_slice}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corey Donohoe"]
  s.date = %q{2009-01-21}
  s.description = %q{Merb Slice that allows you to process stuff with braintree, without storing credit cards and shit}
  s.email = %q{atmos@atmos.org}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/braintree_transparent_redirect_slice", "lib/braintree_transparent_redirect_slice/merbtasks.rb", "lib/braintree_transparent_redirect_slice/slicetasks.rb", "lib/braintree_transparent_redirect_slice/spectasks.rb", "lib/braintree_transparent_redirect_slice/version.rb", "lib/braintree_transparent_redirect_slice.rb", "spec/fixtures", "spec/fixtures/user.rb", "spec/models", "spec/models/credit_card_info_spec.rb", "spec/requests", "spec/requests/credit_cards", "spec/requests/credit_cards/adding_a_card_spec.rb", "spec/requests/credit_cards/deleting_a_card_spec.rb", "spec/requests/credit_cards/updating_a_card_spec.rb", "spec/requests/main_spec.rb", "spec/requests/payments", "spec/requests/payments/issuing_a_transaction_spec.rb", "spec/spec_helper.rb", "spec/spec_helpers", "spec/spec_helpers/braintree", "spec/spec_helpers/braintree/api_helper.rb", "spec/spec_helpers/edit_form_helper.rb", "app/controllers", "app/controllers/application.rb", "app/controllers/credit_cards.rb", "app/controllers/main.rb", "app/controllers/payments.rb", "app/helpers", "app/helpers/application_helper.rb", "app/helpers/credit_cards_helper.rb", "app/models", "app/models/braintree", "app/models/braintree/gateway_request.rb", "app/models/braintree/gateway_response.rb", "app/models/braintree/query.rb", "app/models/braintree/transaction_info.rb", "app/models/credit_card.rb", "app/models/credit_card_info.rb", "app/models/credit_card_invoice.rb", "app/views", "app/views/braintree_transparent_redirect_slice", "app/views/braintree_transparent_redirect_slice/credit_cards", "app/views/braintree_transparent_redirect_slice/credit_cards/_form.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/_gateway_request.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/destroy.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/edit.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/index.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/new.html.haml", "app/views/braintree_transparent_redirect_slice/credit_cards/show.html.haml", "app/views/braintree_transparent_redirect_slice/payments", "app/views/braintree_transparent_redirect_slice/payments/index.html.haml", "app/views/braintree_transparent_redirect_slice/payments/new.html.haml", "app/views/layout", "app/views/layout/braintree_transparent_redirect_slice.html.haml", "app/views/main", "app/views/main/index.html.haml", "public/javascripts", "public/javascripts/master.js", "public/stylesheets", "public/stylesheets/master.css", "stubs/app", "stubs/app/controllers", "stubs/app/controllers/application.rb", "stubs/app/controllers/main.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/atmos/braintree_transparent_redirect_slice/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb Slice that allows you to process stuff with braintree, without storing credit cards and shit}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-slices>, [">= 1.0.7.1"])
      s.add_runtime_dependency(%q<libxml-ruby>, ["= 0.9.7"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0.9.8"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0.9.8"])
      s.add_runtime_dependency(%q<merb-auth-core>, [">= 0"])
      s.add_runtime_dependency(%q<merb-auth-more>, [">= 0"])
      s.add_runtime_dependency(%q<merb-haml>, [">= 0"])
      s.add_runtime_dependency(%q<merb-helpers>, [">= 0"])
      s.add_runtime_dependency(%q<merb-assets>, [">= 0"])
      s.add_runtime_dependency(%q<merb-action-args>, [">= 0"])
    else
      s.add_dependency(%q<merb-slices>, [">= 1.0.7.1"])
      s.add_dependency(%q<libxml-ruby>, ["= 0.9.7"])
      s.add_dependency(%q<dm-core>, [">= 0.9.8"])
      s.add_dependency(%q<dm-validations>, [">= 0.9.8"])
      s.add_dependency(%q<merb-auth-core>, [">= 0"])
      s.add_dependency(%q<merb-auth-more>, [">= 0"])
      s.add_dependency(%q<merb-haml>, [">= 0"])
      s.add_dependency(%q<merb-helpers>, [">= 0"])
      s.add_dependency(%q<merb-assets>, [">= 0"])
      s.add_dependency(%q<merb-action-args>, [">= 0"])
    end
  else
    s.add_dependency(%q<merb-slices>, [">= 1.0.7.1"])
    s.add_dependency(%q<libxml-ruby>, ["= 0.9.7"])
    s.add_dependency(%q<dm-core>, [">= 0.9.8"])
    s.add_dependency(%q<dm-validations>, [">= 0.9.8"])
    s.add_dependency(%q<merb-auth-core>, [">= 0"])
    s.add_dependency(%q<merb-auth-more>, [">= 0"])
    s.add_dependency(%q<merb-haml>, [">= 0"])
    s.add_dependency(%q<merb-helpers>, [">= 0"])
    s.add_dependency(%q<merb-assets>, [">= 0"])
    s.add_dependency(%q<merb-action-args>, [">= 0"])
  end
end
