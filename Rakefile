require 'rubygems'
require 'rake/gempackagetask'

require 'merb-core'
require 'merb-core/tasks/merb'
require 'lib/braintree_transparent_redirect_slice/version'

GEM_NAME = "braintree_transparent_redirect_slice"
AUTHOR = "Corey Donohoe"
EMAIL = "atmos@atmos.org"
HOMEPAGE = "http://github.com/atmos/braintree_transparent_redirect_slice/"
SUMMARY = "Merb Slice that allows you to process stuff with braintree, without storing credit cards and shit" 
GEM_VERSION = BraintreeTransparentRedirectSlice::VERSION

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency 'merb-slices', '>= 1.0.7.1'
  s.add_dependency 'libxml-ruby', '=0.9.7'
  s.add_dependency 'dm-core', '>=0.9.8'
  s.add_dependency 'dm-validations', '>=0.9.8'
  s.add_dependency 'merb-auth-core'
  s.add_dependency 'merb-auth-more'
  s.add_dependency 'merb-haml'
  s.add_dependency 'merb-helpers'
  s.add_dependency 'merb-assets'
  s.add_dependency 'merb-action-args'
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec,app,public,stubs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
desc 'Default: run spec examples'
task :default => 'spec'
