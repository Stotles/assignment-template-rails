# Usage:

```
gem install rails

rails new \
  --webpacker=react \
  -C -S -M -O \
  --skip-action-mailer \
  --skip-active-storage \
  --skip-action-text \
  --skip-turbolinks \
  -m https://raw.githubusercontent.com/Stotles/rails_templates/master/react_ts_ant.rb \
  MY_APP_NAME_HERE

cd MY_APP_NAME_HERE
```

# Getting up and running

```
bin/rails server

# in a separate pane:
# you may have to be patient initially, but subsequent hot reloading should be quick
bin/webpack-dev-server
```

This gives you the following setup:

- Rails
- React
- TypeScript
- Ant Design
- scss modules

It also includes a sample helloworld page to get you going. Note: you do not have to use typescript, react or ant design! They are merely included for your convenience.
