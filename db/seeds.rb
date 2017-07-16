user = User.new(email: "eaderecho@gmail.com", first_name: "Eduardo", last_name: "Derecho")
user.password = ENV["DEFAULT_PASSWORD"]
user.save!

user = User.new(email: "maxi.derecho@gmail.com", first_name: "Maximiliano", last_name: "Derecho")
user.password = ENV["DEFAULT_PASSWORD"]
user.save!

user = User.new(email: "nicolas.derecho@gmail.com", first_name: "Nicolas", last_name: "Derecho")
user.password = ENV["DEFAULT_PASSWORD"]
user.save!