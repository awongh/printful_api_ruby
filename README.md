# An API Wrapper for Printful

This gem is an API wrapper for Printful

```ruby
gem 'printful_api_ruby'
```

Then instantiate the client using the oAuth tokens (this example implies using Foreman and an .env file that contain these values):

```ruby
Printful::Client.new({
  consumer_token: ENV['PRINTFUL_CONSUMER_TOKEN'], 
  consumer_secret: ENV['PRINTFUL_CONSUMER_SECRET'], 
  oauth_token: ENV['PRINTFUL_OAUTH_TOKEN'], 
  oauth_secret: ENV['PRINTFUL_OAUTH_SECRET']
})
```

The consumer_token and consumer_secret are supplied by Prinftul once you create a developer account and an app.

The oauth_token and oauth_secret are the access tokens that are received from the OAuth transaction. In this Sinatra method that uses the OmniAuth callback method, you can see how to parse the access tokens out of the response and use it to instantiate the Reshape client along with your pre-defined consumer tokens:

```ruby
get '/auth/:provider/callback' do
  auth = request.env['omniauth.auth']
  
  client = Reshape::Client.new({
    consumer_token: ENV['PRINTFUL_CONSUMER_KEY'], 
    consumer_secret: ENV['PRINTFUL_CONSUMER_SECRET'], 
    oauth_token: auth.credentials.token,
    oauth_secret: auth.credentials.secret
  })

  products = client.products

  erb "<h1>#{params[:provider]}</h1>
       <pre>#{JSON.pretty_generate(auth)}</pre>
       <pre>#{JSON.pretty_generate(products)}</pre>"
end
```

Check the examples directory for a full example using Sinatra.

## Tests

Note that rspec is using vcr for fixtures. If you delete files from spec/fixtures/cassettes, the tests will fail. They use dummy tokens, and will attempt to communicate with the live API with missing OAuth parameters. In order to test against the live API and generate your own cassettes, create a .env file with the following parameters:

```ruby
	PRINTFUL_CONSUMER_TOKEN='your consumer token from Printful'
	PRINTFUL_CONSUMER_SECRET='your consumer secret from Printful'
	PRINTFUL_OAUTH_TOKEN='OAuth token that are returned from a successful authentication'
	PRINTFUL_OAUTH_SECRET='OAuth secret that are returned from a successful authentication'
```

From there, you can run _foreman run bundle exec rake_ to regenerate the cassettes using live data in conjunction with your credentials. Just a word of warning: don't commit those cassettes to a public repo, as they will contain valid tokens that could potentially be used to hijack a live application that uses those credentials.

## Examples
```
# init client as above
response = client.post('/orders',{
  foo: 'bar'
})
```

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

```
PRINTFUL_CONSUMER_TOKEN='y' PRINTFUL_CONSUMER_SECRET='o' PRINTFUL_OAUTH_TOKEN='h' PRINTFUL_OAUTH_SECRET='s' rake test
PRINTFUL_CONSUMER_TOKEN='y' PRINTFUL_CONSUMER_SECRET='o' PRINTFUL_OAUTH_TOKEN='h' PRINTFUL_OAUTH_SECRET='s' rspec -rbyebug --color --format documentation --require ./spec/spec_helper spec
PRINTFUL_CONSUMER_TOKEN='y' PRINTFUL_CONSUMER_SECRET='o' PRINTFUL_OAUTH_TOKEN='h' PRINTFUL_OAUTH_SECRET='s' rspec --backtrace --color --format documentation --require ./spec/spec_helper spec
```
