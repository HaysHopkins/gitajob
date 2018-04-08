
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gitajob/version"

Gem::Specification.new do |spec|
  spec.name          = "gitajob"
  spec.version       = Gitajob::VERSION
  spec.authors       = ["w.hayshopkins@gmail.com"]
  spec.email         = ["w.hayshopkins@gmail.com"]

  spec.description   = "This program checks the health of a given website via the CLI. Run bin/gitajob for more info."
  spec.summary = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.20.0"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
