# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザー
User.create(name: "管理者",
            email: "admin@email.com",
            password: "000000",
            password_confirmation: "000000",
            admin: true
            )

User.create(name: "小貫 祐汰", 
            email: "onu4648yu@icloud.com", 
            affiliation: "成田", 
            employee_number: "001",
            password: "111111", 
            password_confirmation: "111111",
            admin: false,
            sperior: true
            )

User.create(name: "金本 真弥",
            email: "kanamoto@email.com",
            affiliation: "山武",
            employee_number: "011",
            password: "222222",
            password_confirmation: "222222",
            admin: false,
            sperior: false,
            finishing_work_at: "18:00"
            )
            
User.create(name: "吉田 一貴",
            email: "yoshida@email.com",
            affiliation: "西条",
            employee_number: "101",
            password: "333333",
            password_confirmation: "333333",
            admin: false,
            sperior: false,
            finishing_work_at: "18:00"
            )
            
# テストタイム

# ユーザー4

Attendance.create(day: "2018-11-01",
                  arrival: "2018-11-01 08:49:00",
                  leave: "2018-11-01 17:31:00",
                  user_id: 4,
                  type: "Normal"
                  )    
                
Attendance.create(day: "2018-11-03",
                  arrival: "2018-11-03 08:43:00",
                  leave: "2018-11-03 17:15:00",
                  user_id: 4,
                  type: "Normal"
                  )
                  
Attendance.create(day: "2018-11-4",
                   arrival: "2018-11-04 08:56:00",
                   leave: "2018-11-04 18:02:00",
                   user_id: 4,
                   type: "Normal"
                   )
Attendance.create(day: "2018-12-01",
                  arrival: "2018-12-1 09:00:00",
                  leave: "2018-12-1 17:0:00",
                  user_id: 4,
                  type: "Normal",
                  )    
                
Attendance.create(day: "2018-12-02",
                  arrival: "2018-12-2 09:00:00",
                  leave: "2018-12-2 17:00:00",
                  user_id: 4,
                  type: "Normal",
                  )
                  
#Attendance.create(day: "2018-11-01",
#                   arrival: "2018-11-1 8:30:00",
#                   leave: "2018-11-1 20:30:00",
#                   user_id: 4,
#                   type: "Revise",
#                   sperior_id: "2",
#                   remark: "体調不良の為、早退",
#                   state: "申請中"
#                   )
                   
#Attendance.create(day: "2018-11-2",
#                   arrival: "2018-11-2 06:30:00",
#                   leave: "2018-11-2 20:30:00",
#                   user_id: 4,
#                   type: "Revise",
#                   sperior_id: "2",
#                   remark: "早番の為、出勤時間変更",
#                   state: "申請中"
#                   )
                   
#Attendance.create(day: "2018-11-02",
#                   finish_at: "2018-11-2 23:35:00",
#                   user_id: 4,
#                   type: "Overtime",
#                   sperior_id: "2",
#                  remark: "タスク消化のため",
#                  state: "申請中"
#                  )
                   
Attendance.create(day: "2018-12-05",
                   arrival: "2018-12-5 08:52:00",
                   leave: "2018-12-5 22:53:00",
                   user_id: 2,
                   type: "Normal"
                   )
                  
# ユーザー3
                   
Attendance.create(day: "2018-11-01",
                  arrival: "2018-11-01 08:42:00",
                  leave: "2018-11-01 17:45:00",
                  user_id: 3,
                  type: "Normal"
                  )    
                
Attendance.create(day: "2018-11-03",
                  arrival: "2018-11-03 08:46:00",
                  leave: "2018-11-03 17:11:00",
                  user_id: 3,
                  type: "Normal"
                  )
                  
Attendance.create(day: "2018-11-4",
                   arrival: "2018-11-04 08:41:00",
                   leave: "2018-11-04 18:06:00",
                   user_id: 3,
                   type: "Normal"
                   )
Attendance.create(day: "2018-12-01",
                  arrival: "2018-12-1 08:39:00",
                  leave: "2018-12-1 17:34:00",
                  user_id: 3,
                  type: "Normal",
                  )    
                
#Attendance.create(day: "2018-11-01",
#                  arrival: "2018-11-1 08:39:00",
#                  leave: "2018-11-1 20:49:00",
#                  user_id: 3,
#                  type: "Revise",
#                  sperior_id: "2",
#                  remark: "間違えて退勤を切った為",
#                  state: "申請中"
#                  )
                  
Attendance.create(day: "2018-12-03",
                   arrival: "2018-12-3 08:52:00",
                   leave: "2018-12-3 18:21:00",
                   user_id: 3,
                   type: "Normal"
                  )

#Attendance.create(day: "2018-11-03",
#                   finish_at: "2018-11-3 23:35:00",
#                   user_id: 3,
#                   type: "Overtime",
#                   sperior_id: "2",
#                  remark: "タスク消化のため",
#                  state: "申請中"
#                  )
                  
Attendance.create(day: "2018-12-04",
                   arrival: "2018-12-4 08:40:00",
                   leave: "2018-12-4 17:11:00",
                   user_id: 3,
                   type: "Normal"
                   )
Attendance.create(day: "2018-12-05",
                   arrival: "2018-12-5 08:43:00",
                   leave: "2018-12-5 17:04:00",
                   user_id: 3,
                   type: "Normal"
                )

# 申請テストデータ

# ユーザー3から2

#user = User.find(2)
#tester_one = User.find(3)
#tester_two = User.find(4)
#testers = []
#testers.push(tester_one)
#testers.push(tester_two)
#testers.each {|t| t.approy(user)}