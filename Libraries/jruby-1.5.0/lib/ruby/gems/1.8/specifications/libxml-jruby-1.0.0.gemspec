# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{libxml-jruby}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Guterl", "Uwe L. Korn"]
  s.date = %q{2010-04-07}
  s.description = %q{Lixml replacement for JRuby in 100% Java}
  s.email = %q{uwelk@xhochy.org}
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["History.txt", "README.txt", "Rakefile", "VERSION", "VERSION.yml", "lib/libxml-jruby.rb", "lib/libxml-jruby/xml.rb", "lib/libxml-jruby/xml/attr.rb", "lib/libxml-jruby/xml/attributes.rb", "lib/libxml-jruby/xml/document.rb", "lib/libxml-jruby/xml/dtd.rb", "lib/libxml-jruby/xml/node.rb", "lib/libxml-jruby/xml/ns.rb", "lib/libxml-jruby/xml/parser.rb", "lib/libxml-jruby/xml/xpath.rb", "lib/libxml.rb", "lib/xml.rb", "lib/xml/libxml.rb", "test/tc_node_copy.rb", "test/tc_well_formed.rb", "test/tc_node_attr.rb", "test/ets_copy_bug3.rb", "test/tc_node_xlink.rb", "test/tc_document.rb", "test/tc_properties.rb", "test/ets_gpx.rb", "test/tc_html_parser.rb", "test/tc_document_write.rb", "test/tc_xpointer.rb", "test/tc_attributes.rb", "test/tc_dtd.rb", "test/ets_node_gc.rb", "test/ets_doc_to_s.rb", "test/test_suite.rb", "test/tc_node_set.rb", "test/tc_schema.rb", "test/tc_node_text.rb", "test/etc_doc_to_s.rb", "test/tc_node_comment.rb", "test/ts_working.rb", "test/tc_deprecated_require.rb", "test/tc_node_cdata.rb", "test/tc_node_set2.rb", "test/tc_relaxng.rb", "test/tc_node.rb", "test/tc_xpath_context.rb", "test/ets_doc_file.rb", "test/tc_parser.rb", "test/tc_parser_context.rb", "test/ets_copy_bug.rb", "test/tc_ns.rb", "test/tc_xpath.rb", "test/tc_node_edit.rb", "test/tc_reader.rb", "test/tc_traversal.rb", "test/tc_sax_parser.rb", "test/test_libxml-jruby.rb", "test/ets_tsr.rb", "test/tc_xinclude.rb", "test/model/default_validation_bug.rb"]
  s.homepage = %q{http://github.com/xhochy/libxml-jruby}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Libxml replacement for JRuby}
  s.test_files = ["test/tc_node_copy.rb", "test/tc_well_formed.rb", "test/tc_node_attr.rb", "test/ets_copy_bug3.rb", "test/tc_node_xlink.rb", "test/tc_document.rb", "test/tc_properties.rb", "test/ets_gpx.rb", "test/tc_html_parser.rb", "test/tc_document_write.rb", "test/tc_xpointer.rb", "test/tc_attributes.rb", "test/tc_dtd.rb", "test/ets_node_gc.rb", "test/ets_doc_to_s.rb", "test/test_suite.rb", "test/tc_node_set.rb", "test/tc_schema.rb", "test/tc_node_text.rb", "test/etc_doc_to_s.rb", "test/tc_node_comment.rb", "test/ts_working.rb", "test/tc_deprecated_require.rb", "test/tc_node_cdata.rb", "test/tc_node_set2.rb", "test/tc_relaxng.rb", "test/tc_node.rb", "test/tc_xpath_context.rb", "test/ets_doc_file.rb", "test/tc_parser.rb", "test/tc_parser_context.rb", "test/ets_copy_bug.rb", "test/tc_ns.rb", "test/tc_xpath.rb", "test/tc_node_edit.rb", "test/tc_reader.rb", "test/tc_traversal.rb", "test/tc_sax_parser.rb", "test/test_libxml-jruby.rb", "test/ets_tsr.rb", "test/tc_xinclude.rb", "test/model/default_validation_bug.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
