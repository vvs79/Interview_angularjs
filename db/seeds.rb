# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

topics = %w("HTML", "CSS", "JavaScript", "Ruby")

User.create!(first_name: 'Admin', last_name: 'Admin', email: 'admin@admin.com', password: '12345678', admin: true, approved: true)
User.create!(first_name: 'Ivan', last_name: 'Ivanov', email: 'inter@inter.com', password: '12345678', admin: false, approved: true)

20.times do |_|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = "password"
  User.create!(first_name: first_name, last_name: last_name, email: email, password:  password, admin: false, approved: true)
end

10.times do |_|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = "password"
  User.create!(first_name:  first_name, last_name: last_name, email: email, password:  password, admin: false, approved: false)
end

topics.each do |t|
  Topic.create!(title: t)
end

questions = [
  ["What does HTML stand for?", "Hyper Text Markup Language", 1],
  ["Who is making the Web standards?", "The World Wide Web Consortium", 1],
  ["What is the HTML element for the largest heading?", "<h1>", 1],
  ["What is the HTML element for inserting a line break?", "<br>", 1],
  ["What is the HTML for adding a background color?", "<body style='background-color:yellow;'>", 1],
  ["What is the HTML element to define important text", "<strong>", 1],
  ["What is the HTML for creating a hyperlink?", "<a href = 'google.com'>Google</a>", 1],
  ["What is the HTML for making a checkbox?", "<input type='checkbox'>", 1],
  ["What is the HTML for making a drop-down list?", "<select>", 1],
  ["What is the HTML for inserting an image?", "<img src='image.gif' alt='MyImage'>", 1],
  ["What is the correct HTML for inserting a background image?", "<body style='background-image:url(background.gif)'>", 1],
  ["Which HTML attribute specifies an alternate text for an image, if the image cannot be displayed?", "alt", 1],

  ["What does CSS stand for?", "Cascading Style Sheets", 2],
  ["What is the correct HTML for referring to an external style sheet?", "<link rel='stylesheet' type='text/css' href='mystyle.css'>", 2],
  ["Where in an HTML document is the correct place to refer to an external style sheet?", "In the <head> section", 2],
  ["How do you insert a comment in a CSS file?", " /* this is a comment */", 2],
  ["Which CSS property controls the text size?", "font-size", 2],
  ["How do you display hyperlinks without an underline?", "a {text-decoration:none;}", 2],
  ["How do you make each word in a text start with a capital letter?", "text-transform: capitalize", 2],
  ["When using the padding property; are you allowed to use negative values?", "No", 2],
  ["How do you make a list that lists its items with squares?", "list-style-type: square;", 2],
  ["How do you select an element with id 'demo'?", " #demo", 2],
  ["How do you select elements with class name 'test'?", ".text", 2],
  ["What is the default value of the position property?", "static", 2],

  ["What is the correct JavaScript syntax to change the content of the HTML element with id?", "document.getElementById('demo').innerHTML = 'Hello World!';", 3],
  ["Where is the correct place to insert a JavaScript?", "Both the <head> section and the <body> section are correct", 3],
  ["What is the correct syntax for referring to an external script called 'xxx.js'?", "<script src='xxx.js'>", 3],
  ["How do you call a function named 'myFunction'?", "myFunction()", 3],
  ["How does a FOR loop start?", "for (i = 0; i <= 5; i++)", 3],
  ["What is the correct way to write a JavaScript array?", "var colors = ['red', 'green', 'blue']", 3],
  ["How do you round the number 7.25, to the nearest integer?", "Math.round(7.25)", 3],
  ["How do you find the number with the highest value of x and y?", "Math.max(x, y)", 3],
  ["Which event occurs when the user clicks on an HTML element?", "onclick", 3],
  ["How do you declare a JavaScript variable?", "var carName", 3],
  ["What will the following code return: Boolean(10 > 9)", "true", 3],
  ["Is JavaScript case-sensitive?", "Yes", 3],

  ["Name at least 3 ways to call a method in Ruby?", " 1)greeter.greeting 2)greeter.send :greeting 3)greeter.method(:greeting).call ", 4],
  ["What is an instance?", "nstance: is an object which was instantiated from a Class", 4],
  ["What is a class?", "Class: is the blueprint from which individual objects are created.
  Classes in Ruby are first-class objects-each is an instance of class Class.", 4],
  ["What is a module?", "Module: is a collection of methods and constants. You can't make an instance of a module;
  the way you access the constants and methods inside it depends on it's definition.", 4],
  ["What is the difference between include and extend?", "include mixes a module as instance methods or constants and
  extend mixes a module as class methods; also you can extend a singleton object instance using this syntax.", 4],
  ["Are hashes ordered? Does it matter order of Keys and Pairs?", "No", 4],
  ["How would you return all the keys in a hash?", "hash.keys", 4],
  ["These keys that are returned... what is their class?", "Array", 4],
  ["What is the use of super in Ruby Rails? ", "Ruby uses the super keyword to call the superclass implementation of the current method", 4],
  ["What is the use of load and require in ruby? ", "Require() loads and processes the Ruby code from a separate file,
  including whatever classes, modules, methods, and constants are in that file into the current scope", 4],
  ["Explain the use of global variable $ in Ruby.", "If you declare one variable as global we can access any where, where as class variable.", 4],
  ["Explain the difference between nil and false in ruby.", "False is a boolean datatype. Nil is not a data type.", 4]
]

questions.each do |question, answer, topic|
  Question.create!(content: question, answer: answer, topic_id: topic, level: 'beginner')
end

99.times do |name|
  name = Faker::Name.name
  Template.create!(name:  name)
end
