#= XML parser for Jasson's project

module XML

  class Element < Hash
    include Module.new{
      def method_missing arg
        self[arg] || super(arg)
      end
    }
  end

  class Document < Element

    def initialize(xml)
      stream = File.open(xml, 'r:utf-8')
      Kernel.send(:define_method, :read_line) do
        @line = stream.readline
      end

      @ans = Array.new
      def read
        read_line rescue return
        case @line
        when /<\//
          @ans.pop
        when /<(.+?)>/
          @ans << $1
        when /(\S+)\s*=\s*(.+)/
          ans_chain = ''
          @ans.each do |ans|
            ans_chain += "[:#{ans}]"
            eval "self#{ans_chain} ||= Element.new"
          end

          eval "self[:#{@ans.join('][:')}][:#{$1}] = #{$2}"
        end
        read
      end

      read
    end


  end


end

