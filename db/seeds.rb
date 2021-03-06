User.destroy_all
Project.destroy_all
Task.destroy_all
Note.destroy_all
TaskCategory.destroy_all
ProjectCategory.destroy_all

user_array = []
5.times do
  create = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    department: "Teambase",
    password: "chicken",
    image_url: "http://www.fillmurray.com/100/100"
  )
  user_array.push create
end
puts "5 Users Created"
project_array = []
5.times do |i|
  create = Project.create!(
    name: Faker::TvShows::GameOfThrones.character,
    due_date: Faker::Date.forward(days: 23),
    status: "In Progress",
    description: Faker::TvShows::GameOfThrones.quote,
    progress: rand(1..100),
    priority: rand(1..5) * i
  )
  project_array.push create
end
puts "5 Projects Created"
task_array = []
15.times do |i|
  num = rand(1..3)
  status = ""
  if num == 1
    status = "New"
  elsif num == 2
    status = "In Progress"
  elsif num == 3
    status = "Complete"
  end

  create = Task.create!(
    name: Faker::TvShows::GameOfThrones.character,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    due_date: Faker::Date.forward(days: 23),
    status: status,
    description: Faker::TvShows::GameOfThrones.quote,
    progress: rand(1..100),
    priority: rand(1..5) * i
  )
  task_array.push create
end
puts "15 Tasks Created"
note_array = []
15.times do
  create = Note.create!(
    note: Faker::Lorem.paragraph(sentence_count: rand(1..4))
  )
  note_array.push create
end
puts "15 Notes Created"

task_category_array = []
5.times do
  create = TaskCategory.create!(
    name: Faker::Beer.brand
  )
  task_category_array.push(create)
end
puts "5 Task categories Created"

project_category_array = []
5.times do
  create = ProjectCategory.create!(
    name: Faker::Job.title
  )
  project_category_array.push(create)
end
puts "5 Project categories Created"

# p task_array
set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    project_array[set1].tasks << task_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    project_array[set2].tasks << task_array[i]
    set2 += 1
  else
    project_array[set3].tasks << task_array[i]
    set3 += 1
  end
end

puts "Testing projects -< tasks associations:"
puts "The task '#{ Task.first.name }' is on project #{Task.first.project.name}"
puts "The project #{ Project.last.name } has task: #{ Project.last.tasks.pluck(:name).join(', ') }"

# p note_array
set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    task_array[set1].notes << note_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    task_array[set2].notes << note_array[i]
    set2 += 1
  else
    task_array[set3].notes << note_array[i]
    set3 += 1
  end
end

puts "Testing note -< tasks associations:"
puts "The note '#{ Note.first.note }' is on task #{Note.first.task.name}"
puts "The task #{ Task.last.name } has note: #{ Task.last.notes.pluck(:note).join(', ') }"
# p note_array
set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    user_array[set1].notes << note_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    user_array[set2].notes << note_array[i]
    set2 += 1
  else
    user_array[set3].notes << note_array[i]
    set3 += 1
  end
end

puts "Testing note -< users associations:"
puts "The note '#{ Note.first.note }' is on user #{Note.first.user.name}"
puts "The user #{ User.last.name } has note: #{ User.last.notes.pluck(:note).join(', ') }"

set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    task_array[i].users << user_array[0] << user_array[1] << user_array[2]
  elsif i > 4 && i <= 9
    task_array[i].users << user_array[2] << user_array[3] << user_array[4]
  else
    task_array[i].users << user_array[4] << user_array[0] << user_array[2]
  end
end

puts "Testing users >-< tasks associations:"
puts "The task '#{ Task.first.name }' has users #{Task.first.users.pluck(:name).join(',')}"
puts "The user #{ User.last.name } has tasks: #{ User.last.tasks.pluck(:name).join(', ') }"

5.times do |i|

    user_array[i].projects << project_array[0] << project_array[1] << project_array[2] << project_array[3] << project_array[4]

end

puts "Testing users >-< project associations:"
puts "The project '#{ Project.first.name }' has users #{Project.first.users.pluck(:name).join(',')}"
puts "The user #{ User.last.name } has projects: #{ User.last.projects.pluck(:name).join(', ') }"

set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    task_category_array[set1].tasks << task_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    task_category_array[set2].tasks << task_array[i]
    set2 += 1
  else
    task_category_array[set3].tasks << task_array[i]
    set3 += 1
  end
end

puts "Testing task -< task_category:"
puts "The task '#{ Task.first.name }' has category #{Task.first.task_category.name}"
puts "The category #{ TaskCategory.last.name } has task: #{ TaskCategory.last.tasks.pluck(:name).join(', ') }"

set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    project_category_array[set1].projects << project_array[0]
    set1 += 1
  elsif i > 4 && i <= 9
    project_category_array[set2].projects << project_array[2]
    set2 += 1
  else
    project_category_array[set3].projects << project_array[4]
    set3 += 1
  end
end

puts "Testing project -< project_category:"
puts "The project '#{ Project.first.name }' has category #{Project.first.project_category.name}"
puts "The category #{ ProjectCategory.last.name } has task: #{ ProjectCategory.last.projects.pluck(:name).join(', ') }"
