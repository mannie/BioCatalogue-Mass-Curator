module LibXMLJRuby
  module XML
    class Attributes
      include Enumerable
      
      class << self
        def from_java(java_obj)
          attrs = XML::Attributes.new
          attrs.java_obj = java_obj
          attrs
        end
      end
      
      attr_accessor :java_obj
      
      def initialize
        @attribute_cache = {}
      end
            
      def each
        i = 0
        while(i < length)
          yield get_attribute(java_obj.attributes.item(i).name)
          i += 1
        end
      end
            
      def length
        java_obj.attributes.length
      end
      
      def [](name)
        attr = get_attribute(name)
        attr ? attr.value : nil
      end
      
      def []=(name, value)
        attr = get_attribute(name)
        if attr
          attr.value = value
        else
          java_obj.setAttribute(name.to_s, value.to_s)
        end
      end
      
      def get_attribute_ns(name, ns)
        attr = java_obj.get_attribute_node_ns(name, ns)
        attr ? nil : XML::Attr.from_java(attr)
      end
      
      def get_attribute(name)
        if @attribute_cache[name.to_s]
          @attribute_cache[name.to_s]
        elsif java_obj && java_obj.attributes
          attr = java_obj.attributes.get_named_item(name.to_s)
          if attr
            @attribute_cache[name.to_s] = XML::Attr.from_java(attr)
            @attribute_cache[name.to_s]
          else
            nil
          end
        else
          nil
        end
      end
    end
  end
end
