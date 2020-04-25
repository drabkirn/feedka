class Encryption
  def self.encrypt_data(data)
    crypt = ActiveSupport::MessageEncryptor.new(ENV["encrypt_key"])
    crypt.encrypt_and_sign(data)
  end

  def self.decrypt_data(data)
    crypt = ActiveSupport::MessageEncryptor.new(ENV["encrypt_key"])
    crypt.decrypt_and_verify(data)
  end
end