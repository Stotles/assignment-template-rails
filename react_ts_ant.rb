# stop spring
run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

gem "react-rails"

# set generator defaults in config/environment.rb
environment <<~RUBY
              config.generators do |g|
                g.assets false
                g.helper false
              end
            RUBY

after_bundle do
  generate "react:install"

  run "yarn add antd @types/webpack-env"
  rails_command "webpacker:install:typescript"

  route "root to: 'pages#home'"
  inject_into_file "config/routes.rb", before: "end" do
    <<~RUBY
      namespace :api, defaults: { format: :json } do
        get 'notice/index'
      end

    RUBY
  end

  generate :controller, "pages", "home", "--skip-routes", "--no-test-framework"
  generate :controller, "api/notices", "index", "--skip-routes", "--no-template-engine"

  append_file ".gitignore", <<~TXT
                .env*
              TXT
  run "touch .env"

  run "mv app/javascript/packs/application.js app/javascript/packs/application.tsx"
  run "rm app/javascript/packs/server_rendering.js"
  run "rm app/javascript/packs/hello_typescript.ts"
  run "rm app/javascript/packs/hello_react.jsx"
  run "rm -rf app/assets/stylesheets"

  # hot reloading
  gsub_file "config/webpacker.yml", /hmr: false/, "hmr: true"

  prepend_file "app/javascript/packs/application.tsx" do
    <<~TSX
      import 'antd/dist/antd.min.css';

    TSX
  end

  inject_into_file "app/controllers/pages_controller.rb", after: "def home" do
    <<~RUBY

      @msg = "We typically use typescript and .tsx files for our React components, but you can use .js and .jsx too."
    RUBY
  end

  file("app/views/pages/home.html.erb", <<~ERB, force: true)
    <%= react_component "HelloWorld", { msg: @msg } %>
  ERB

  file "app/javascript/components/HelloWorld.tsx", <<~TSX
         import * as React from 'react';
         import {Typography} from 'antd';

         type Props = {
           msg: string,
         };

         export default function HelloWorld({msg}: Props) {
           return (
               <main style={{textAlign: "center", height: "100%"}}>
                 <header>
                   <Typography.Title level={1}>Hello, World!</Typography.Title>
                 </header>
                 <main>
                   <p>{msg}</p>
                 </main>
                 <footer>
                   Brought to you by <a href="https://www.stotles.com">Stotles</a>
                 </footer>
               </main>
            );
          }
       TSX

  git add: "."
  git commit: "-m 'Initial Commit'"
end
