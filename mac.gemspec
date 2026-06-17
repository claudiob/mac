# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'mac'
  spec.version = '1.0.0'
  spec.authors = ['claudiob']
  spec.email = ['claudiob@users.noreply.github.com']

  spec.summary = 'API Signature with timestamped MAC (Message Authentication Code).'
  spec.description = 'Enhances OpenSSL::HMAC with timestamp.'
  spec.homepage = 'https://github.com/HouseAccountEng/mac'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/HouseAccountEng/mac'
  spec.metadata['changelog_uri'] = 'https://github.com/HouseAccountEng/mac'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'base64'
  spec.add_dependency 'openssl'
  spec.add_dependency 'rack'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'simplecov'
end
