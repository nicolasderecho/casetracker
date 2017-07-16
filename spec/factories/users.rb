FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }  
    email { Faker::Internet.safe_email }
    password '10pines'
    password_digest { |user| BCrypt::Password.create(user.password) }    
    #avatar { Rack::Test::UploadedFile.new( File.join(Rails.root, 'app', 'assets', 'images', 'default_avatar','default_avatar.png') ) }
  end
end
