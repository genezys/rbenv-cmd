puts case RUBY_PLATFORM
	when 'java'
		"jruby-#{JRUBY_VERSION}"
	else
		"#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
end
