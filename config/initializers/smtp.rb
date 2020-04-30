if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    domain: ENV["sendgrid_domain"],
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    user_name: "apikey",
    password: ENV["sendgrid_api_key"]
  }
end