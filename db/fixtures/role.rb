Role.seed_once(:id) do |r|
  r.id = 1
  r.name = "superuser"
  r.list_order = 1
end

Role.seed_once(:id) do |r|
  r.id = 2
  r.name = "prueba"
  r.list_order = 2
end