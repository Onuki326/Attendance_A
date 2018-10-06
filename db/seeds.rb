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
            
User.create(name: "吉田 一貴",
            email: "yoshida@email.com",
            affiliation: "西条",
            password: "333333",
            password_confirmation: "333333",
            admin: false)
            
# テストタイム

Attendance.create(day: "2018-09-04",
                  arrival: "2018-09-04 08:49:21",
                  leave: "2018-09-04 17:31:12",
                  user_id: 1,
                  )    
                
Attendance.create(day: "2018-09-05",
                  arrival: "2018-09-05 08:43:21",
                  leave: "2018-09-05 17:15:45",
                  user_id: 1,
                  )
                  
Attendance.create(day: "2018-09-6",
                   arrival: "2018-09-06 08:56:13",
                   leave: "2018-09-06 18:02:04",
                   user_id: 1,
                   )
Attendance.create(day: "2018-010-10",
                  arrival: "2018-10-10 07:33:41",
                  leave: "2018-10-10 22:33:12",
                  user_id: 1,
                  )    
                
Attendance.create(day: "2018-10-11",
                  arrival: "2018-10-11 08:43:21",
                  leave: "2018-10-11 23:13:45",
                  user_id: 1,
                  )
                  
Attendance.create(day: "2018-10-12",
                   arrival: "2018-10-12 08:56:13",
                   leave: "2018-10-12 23:57:04",
                   user_id: 1,
                   )
Attendance.create(day: "2018-10-13",
                   arrival: "2018-10-13 08:40:51",
                   leave: "2018-10-13 23:54:22",
                   user_id: 1,
                   )
Attendance.create(day: "2018-10-14",
                   arrival: "2018-10-14 08:52:36",
                   leave: "2018-10-14 22:53:32",
                   user_id: 1,
                   )