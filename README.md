# Message Authentication Code (MAC) with SHA256 and signature

## Available methods

Sign a message:

```ruby
mac = Mac.sign message:, secret:
mac.timestamp # => 1779489515999
mac.signature # => 46f5297a94d0050ba6039bfcb12d6e4c1f955e39b34f98cf2bd5f9720b34ac49
```

Verify a signed message:

```ruby
mac = Mac.new message:, secret:
mac.signed? signature:, timestamp: # true
```

## Tests

Run `bundle exec ruby -Itest test/mac_test.rb`