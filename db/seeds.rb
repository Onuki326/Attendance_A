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
Attendance.create(day: "2018-09-09",
                  arrival: "2018-9-9 12:26:06",
                  leave: nil,
                  user_id: 1,
                  )
                  
Attendance.create(day: "2018-09-10",
                  arrival: "2018-09-10 04:33:32",
                  leave: nil,
                  user_id: 1,
                  )    
                
Attendance.create(day: "2018-09-11",
                  arrival: "2018-09-11 15:13:45",
                  leave: nil,
                  user_id: 1,
                  )
                  
Attendance.create(day: "2018-09-07",
                   arrival: "2018-09-7 14:57:32",
                   leave: nil,
                   user_id: 1,
                   )                  