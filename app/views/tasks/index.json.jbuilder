json.array! @tasks do |task|
  json.id task.id
  json.title task.title
  json.completed task.completed
end
