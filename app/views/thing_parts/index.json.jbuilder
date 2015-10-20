json.array! @thing_parts do |thing_part|
  json.id thing_part.id
  json.name thing_part.name
  json.field1 thing_part.field1
end