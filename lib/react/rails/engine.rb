module React
  module Rails
    class Engine < ::Rails::Engine
      initializer "react_rails.setup_engine", :group => :all do |app|
        sprockets_env = app.assets || Sprockets # Sprockets 3.x expects this in a different place
        if sprockets_env.respond_to? :register_engine
          sprockets_env.register_engine(".jsx", React::JSX::Template)
        else
          sprockets_env.register_mime_type 'text/jsx', extensions: ['.jsx', '.js.jsx']
          sprockets_env.register_transformer 'text/jsx', 'application/javascript', React::JSX
        end
      end
    end
  end
end
