json.array! @answers do |answer|
  json.(answer, :id, :answer)
end
