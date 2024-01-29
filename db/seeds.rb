Attendance.destroy_all
Application.destroy_all
Activity.destroy_all
User.destroy_all
ActiveRecord::Base.connection.execute("TRUNCATE TABLE attendances, applications, activities, users RESTART IDENTITY")

User.create!({
  email: "bruh@gmail.com",
  password: 123456,
  full_name: "Nguyen Quang Minh",
  handphone: 123456789,
  age: 145,
  is_male: false,
  is_admin: true
})

Activity.create!({
  title: "Bruh",
  overview: "bruh",
  body: "bruh",
  manpower_needed: 69,
  location: "bruh town",
  time_start: 6969696969696969,
  time_end: 6969696969696969
})