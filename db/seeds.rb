Institutioncategory.delete_all
Institutiontag.delete_all
Classcategory.delete_all
Classtag.delete_all
Userclass.delete_all
Category.delete_all
Feedback.delete_all
Tag.delete_all
Friendship.delete_all
Invite.delete_all
Classinfo.delete_all
Favoriteinstitution.delete_all
Institution.delete_all
User.delete_all

100.times do
  User.create!(username:Faker::Name.first_name, password:'ryon',password_confirmation:'ryon',email:Faker::Internet.email,first_name:Faker::Name.first_name,
              last_name:Faker::Name.last_name,gender:Faker::Gender.binary_type,birthday:Faker::Date.birthday(min_age: 18, max_age: 65),country:Faker::Address.country,
              city:Faker::Address.city,province:Faker::Address.state,street:Faker::Address.street_address,building:Faker::Address.building_number,unit:Faker::Address.community,
              zipcode:Faker::Address.zip_code,nationality:Faker::Nation.nationality,phone_number:Faker::PhoneNumber.phone_number,emergency_name:Faker::Name.name,emergency_contact:Faker::PhoneNumber.phone_number,
              is_terminated:Faker::Boolean.boolean,is_searchable:Faker::Boolean.boolean,is_previous_classes_visible:Faker::Boolean.boolean,is_coming_classes_visible:Faker::Boolean.boolean,
              is_favorite_institutions_visible:Faker::Boolean.boolean,name:Faker::Name.name,role:User::ROLES[Faker::Number.within(range: 0..2)])
  Institution.create(name:Faker::Music.album,star_num:Faker::Number.within(range: 1..5),feedback_count:Faker::Number.within(range: 1..5000),general_info:Faker::Lorem.paragraphs(number: 3, supplemental: true),country:Faker::Address.country,
                     city:Faker::Address.city,province:Faker::Address.state,street:Faker::Address.street_address,building:Faker::Address.building_number,unit:Faker::Address.community,
                     zipcode:Faker::Address.zip_code,latitude:1.255+0.2*rand,longitude:103.7+0.3*rand,location_instruction:Faker::Lorem.paragraph_by_chars(number: 1000, supplemental: false)).save!
  Category.create!(name:Faker::Game.genre)
  Tag.create!(name:Faker::Music.genre)
end

100.times do
  Institution.all[Faker::Number.within(range: 1..99)].classinfos.create(
  time:Faker::Time.between_dates(from: Date.today - 5, to: Date.today+5, period: :all),duration_in_min:Faker::Number.within(range: 30..90),
                    name:Faker::Game.title,level:Faker::Number.within(range: 0..5),general_info:Faker::Lorem.paragraph_by_chars(number: 1000, supplemental: false),
                    preparation_info:Faker::Lorem.paragraph_by_chars(number: 1000, supplemental: false),arrival_ahead_in_min:Faker::Number.within(range: 10..30),
                    additional_info: Faker::Lorem.paragraph_by_chars(number: 1000, supplemental: false),vacancies:Faker::Number.within(range: 10..50),
                    is_available:Faker::Boolean.boolean,bookable_before:Faker::Boolean.boolean,bookable_after:Faker::Boolean.boolean,credit:Faker::Number.within(range: 5..20))

end

1000.times do
  Invite.create(user:User.all[Faker::Number.within(range: 1..99)],intended_friend:User.all[Faker::Number.within(range: 1..99)],status:Faker::Number.within(range: 1..2)).save!
  Friendship.create(user:User.all[Faker::Number.within(range: 1..99)],friend:User.all[Faker::Number.within(range: 1..99)]).save!
  Favoriteinstitution.create!(user:User.all[Faker::Number.within(range: 1..99)],institution:Institution.all[Faker::Number.within(range: 1..99)])
  Feedback.create!(star_num:Faker::Number.within(range: 1..5),comment:Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false),user:User.all[Faker::Number.within(range: 1..99)],institution:Institution.all[Faker::Number.within(range: 1..99)],
                   classinfo:Classinfo.all[Faker::Number.within(range: 1..99)])
  Userclass.create!(user:User.all[Faker::Number.within(range: 1..99)],classinfo:Classinfo.all[Faker::Number.within(range: 1..99)],attended:Faker::Boolean.boolean)
  Classtag.create!(classinfo:Classinfo.all[Faker::Number.within(range: 1..99)],tag:Tag.all[Faker::Number.within(range: 1..99)])
  Institutiontag.create!(institution:Institution.all[Faker::Number.within(range: 1..99)],tag:Tag.all[Faker::Number.within(range: 1..99)])
  Classcategory.create!(classinfo:Classinfo.all[Faker::Number.within(range: 1..99)],category:Category.all[Faker::Number.within(range: 1..99)])
  Institutioncategory.create!(institution:Institution.all[Faker::Number.within(range: 1..99)],category:Category.all[Faker::Number.within(range: 1..99)])
end



