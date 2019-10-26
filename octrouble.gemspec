
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "octrouble/version"

Gem::Specification.new do |spec|
  spec.name          = "octrouble"
  spec.version       = Octrouble::VERSION
  spec.authors       = ["rry"]
  spec.email         = ["r.yamakuchi@gmail.com"]

  spec.summary       = %q{Take Issue data from GitHub API.}
  spec.description   = %q{Take Issue data from GitHub API. Gem created by rry for learning purposes.}
  spec.homepage      = "https://github.com/ryamakuchi/octrouble"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "thor", "0.20.3"
  spec.add_dependency "octokit", "4.2.0"
end
