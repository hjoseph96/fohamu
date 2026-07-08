require "openssl"
require "base64"

# Derives Amazon SES SMTP credentials from a standard IAM access key/secret pair,
# per AWS's documented conversion algorithm (SigV4-derived, region-scoped):
# https://docs.aws.amazon.com/ses/latest/dg/smtp-credentials.html
module AwsSesSmtpCredentials
  ALGORITHM_VERSION = "\x04".b
  DATE = "11111111"
  SERVICE = "ses"
  TERMINAL = "aws4_request"
  MESSAGE = "SendRawEmail"

  module_function

  def password(secret_access_key, region)
    signature = hmac("AWS4#{secret_access_key}", DATE)
    signature = hmac(signature, region)
    signature = hmac(signature, SERVICE)
    signature = hmac(signature, TERMINAL)
    signature = hmac(signature, MESSAGE)

    Base64.strict_encode64(ALGORITHM_VERSION + signature)
  end

  def hmac(key, data)
    OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), key, data)
  end
end
