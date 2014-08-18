require 'pathname'

module AutoprefixerRails
  # Register autoprefixer postprocessor in Sprockets and fix common issues
  class Sprockets
    def initialize(processor)
      @processor = processor
    end

    # Add prefixes for `css`
    def process(context, css)
      root   = Pathname.new(context.root_path)
      input  = context.pathname.relative_path_from(root).to_s
      output = input.chomp(File.extname(input)) + '.css'

      @processor.process(css, from: input, to: output).css
    end

    # Register postprocessor in Sprockets depend on issues with other gems
    def install(assets)
      assets.register_postprocessor('text/css', :autoprefixer) do |context, css|
        process(context, css)
      end
    end
  end
end
