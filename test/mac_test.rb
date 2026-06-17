require 'simplecov'
SimpleCov.start { minimum_coverage 100 }
require 'minitest/autorun'

require_relative '../lib/mac'

class MacTest < Minitest::Test
  def test_with_hexdigest
    mac = Mac.sign message: { foo: :bar }.to_json, secret: 'S3kr3t'
    assert mac.signed? signature: mac.signature, timestamp: mac.timestamp
  end

  def test_without_hexdigest
    mac = Mac.sign message: { foo: :bar }.to_json, secret: 'S3kr3t', hexdigest: false
    assert mac.signed? signature: mac.signature, timestamp: mac.timestamp, hexdigest: false
  end
end
