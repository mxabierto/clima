User.seed_once(:email) do |s|
  s.email = "matias@opi.la"
  s.name = "Matias Renta"
  s.password = 'opiopiopi'
  s.password_confirmation = 'opiopiopi'
  s.role_id = 1
end