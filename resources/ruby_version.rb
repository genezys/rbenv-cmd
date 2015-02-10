require "rubygems"

puts case RUBY_PLATFORM
	when 'java'
		"jruby-#{JRUBY_VERSION}"
	else
		if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.1')
			RUBY_VERSION
		else
			"#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
		end
end
