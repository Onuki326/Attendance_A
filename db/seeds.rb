# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザー
User.create(name: "小貫 祐汰", 
            email: "onu4648yu@icloud.com", 
            affiliation: "成田", 
            password: "111111", 
            password_confirmation: "111111",
            admin: true 
            )

User.create(name: "金本 真弥",
            email: "kanamoto@email.com",
            affiliation: "山武",
            password: "222222",
            password_confirmation: "222222",
            admin: false)
            
# テストタイム
Attendance.create(day: "2018-09-10",
                  arrival: "2018-09-10 07:33:32",
                  leave: "2018-09-10 22:33:32",
                  user_id: 1,
                  )    
                
Attendance.create(day: "2018-09-11",
                  arrival: "2018-09-11 08:43:45",
                  leave: "2018-09-11 23:13:45",
                  user_id: 1,
                  )
                  
Attendance.create(day: "2018-09-12",
                   arrival: "2018-09-12 08:56:32",
                   leave: "2018-09-12 23:57:32",
                   user_id: 1,
                   )
Attendance.create(day: "2018-09-13",
                   arrival: "2018-09-13 08:40:32",
                   leave: "2018-09-13 23:54:32",
                   user_id: 1,
                   )
