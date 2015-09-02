require 'execjs'
require 'react/jsx/template'
require 'react/jsx/jsx_transformer'
require 'react/jsx/babel_transformer'
require 'rails'

module React
  module JSX
    DEFAULT_TRANSFORMER = BabelTransformer
    mattr_accessor :transform_options, :transformer_class, :transformer

    # You can assign `React::JSX.transformer_class = `
    # to provide your own transformer. It must implement:
    # - #initialize(options)
    # - #transform(code) => new code
    class << self
      transformer_class = DEFAULT_TRANSFORMER

      def transform(code)
        transformer.transform(code)
      end

      def call(code)
        transformer.transform(code[:data])
      end

      def transformer
        transformer ||= transformer_class.new(transform_options)
      end
    end
  end
end
