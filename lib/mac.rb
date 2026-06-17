require 'base64'
require 'openssl'
require 'rack'

# Provides methods to sign and verify timestamped messages with HMAC SHA256.
class Mac
  # Sets up a message to be signed/verified with a secret.
  def initialize(message:, secret:, timed: true)
    @message = message
    @secret = secret
    @timed = timed
  end

  # Sets up a message and calculates its current signature.
  def self.sign(message:, secret:, timed: true, hexdigest: true)
    new(message: message, secret: secret).tap do |mac|
      mac.sign timestamp: (Time.now if timed), hexdigest: hexdigest
    end
  end

  attr_reader :signature, :timestamp

  # Returns whether the provided signature and timestamp match the signature of the message.
  def signed?(signature:, timestamp: nil, hexdigest: true)
    sign hexdigest: hexdigest, timestamp: timestamp
    Rack::Utils.secure_compare @signature, signature
  end

  # Calculates the signature of the message.
  def sign(timestamp: nil, hexdigest: true)
    @timestamp = timestamp.to_i.to_s if timestamp
    payload = [@timestamp, @message].compact.join '.'
    @signature = if hexdigest
      OpenSSL::HMAC.hexdigest 'SHA256', @secret, payload
    else
      Base64.strict_encode64(OpenSSL::HMAC.digest 'SHA256', @secret, payload)
    end
  end
end
