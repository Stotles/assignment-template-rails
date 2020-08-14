Usage:

```
rails new \
  --database=postgresql \
  --webpacker=react \
  -C -S -M \
  --skip-action-mailer \
  --skip-active-storage \
  --skip-action-text \
  --skip-turbolinks \
  -m https://raw.githubusercontent.com/Stotles/rails_templates/master/react_ts_ant.rb \
  MY_APP_NAME_HERE

cd MY_APP_NAME_HERE
bin/rails server
# in a separate pane:
bin/webpack-dev-server
```

This gives you the following setup:

- Rails
- React
- TypeScript
- Ant Design

It also includes a sample helloworld page to get you going. Note: you do not have to use typescript, react or ant design! They are merely included for your convenience.
