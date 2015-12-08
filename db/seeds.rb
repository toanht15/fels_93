User.create!(name: "Cao-Phuong-Anh", email: "thuanbk56@gmail.com",
  password: "pa0974340719", password_confirmation: "pa0974340719",
  admin_digest: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end

users = User.order(:created_at).take(2)
users.each{|user|
  10.times do |n|
    content = Random.new.rand(4..20)
    category_id = Random.new.rand(1..5)
    Lesson.create!(user_id:user.id, category_id:category_id, content:content)
  end
}

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

15.times do |n|
  name = "Basic #{n+1}"
  des = "study with me"
  Category.create!(name: name, description: des)
end

categories = Category.all
categories.each{|category|
  50.times do |n|
    content = Faker::Lorem.word
    Word.create!(content:content, category_id:category.id)
  end
}

words = Word.all
words.each {|word|
  content = Faker::Lorem.word
  correct = true
  Answer.create!(content: content, correct:correct, word_id:word.id)
}

3.times do |n|
  words.each{|word|
    content = Faker::Lorem.word
    correct = false
    Answer.create!(content: content, correct:correct, word_id:word.id)
  }
end

lessons = Lesson.order(:created_at).take(5)
lessons.each{|lesson|
  category = Category.find_by(id:lesson.category_id)
  20.times do |n|
    word = category.words.first
    word_answer = Answer.where(word_id:word.id).first
    Result.create!(lesson_id:lesson.id, word_id:word.id, answer_id:word_answer.id)
  end
}
