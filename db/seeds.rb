Attendance.destroy_all
Application.destroy_all
Activity.destroy_all
User.destroy_all
ActiveRecord::Base.connection.execute("TRUNCATE TABLE attendances, applications, activities, users RESTART IDENTITY")

user = User.create!({
  email: "imnotminh@gmail.com",
  password: 123456,
  full_name: "Nguyen Quang Minh",
  handphone: 123456789,
  age: 69,
  is_male: true,
  is_admin: true
})

activity1 = Activity.create!({
  title: "Help Needed 1",
  overview: "We need volunteers to help to tutor unprivileged children",
  body: "We need volunteers to help to tutor unprivileged children. Anyone with O-level certificate or higher is welcomed",
  manpower_needed: 10,
  image: "https://i.pinimg.com/originals/f0/ea/45/f0ea45d961454290445a616e4bf71554.jpg",
  location: "Raffles Hall, NUS, Singapore 119278",
  time_start: 1707312683000,
  time_end: 1707312683000
})

activity2 = Activity.create!({
 title: "Help Needed 2",
 overview: "We need volunteers to help to tutor unprivileged children",
 body: "We need volunteers to help to tutor unprivileged children. Anyone with O-level certificate or higher is welcomed",
 manpower_needed: 10,
 image: "https://i.pinimg.com/originals/f0/ea/45/f0ea45d961454290445a616e4bf71554.jpg",
 location: "Raffles Hall, NUS, Singapore 119278",
 time_start: 1707312683000,
 time_end: 1707312683000
})

activity3 = Activity.create!({
 title: "Help Needed 3",
 overview: "We need volunteers to help to tutor unprivileged children",
 body: "We need volunteers to help to tutor unprivileged children. Anyone with O-level certificate or higher is welcomed",
 manpower_needed: 10,
 image: "https://i.pinimg.com/originals/f0/ea/45/f0ea45d961454290445a616e4bf71554.jpg",
 location: "Raffles Hall, NUS, Singapore 119278",
 time_start: 1707312683000,
 time_end: 1707312683000
})

activity4 = Activity.create!({
 title: "Help Needed 4",
 overview: "We need volunteers to help to tutor unprivileged children",
 body: "We need volunteers to help to tutor unprivileged children. Anyone with O-level certificate or higher is welcomed",
 manpower_needed: 10,
 image: "https://i.pinimg.com/originals/f0/ea/45/f0ea45d961454290445a616e4bf71554.jpg",
 location: "Raffles Hall, NUS, Singapore 119278",
 time_start: 1707312683000,
 time_end: 1707312683000
})

Application.create!(user_id: user[:id], activity_id: activity1[:id], accepted: true)
Application.create!(user_id: user[:id], activity_id: activity2[:id], accepted: true)
Application.create!(user_id: user[:id], activity_id: activity3[:id], )
Application.create!(user_id: user[:id], activity_id: activity4[:id], )

Attendance.create!(user_id: user[:id], activity_id: activity1[:id], applications_id: 1, attended: true)
Attendance.create!(user_id: user[:id], activity_id: activity2[:id], applications_id: 2, attended: false)