require 'csv'
  CSV.generate(encoding: Encoding::SJIS) do |csv|
    column_header = [
      "日付",
      "曜日",
      "出社",
      "退社",
      "在社時間",
      "備考"
    ]
    csv << column_header
    @attendances.each do |attendance|
      column_values = [
        "#{attendance.day}",
        "#{@week[attendance.day.wday]}",
        "#{attendance.arrival&.strftime("%H:%M")}",
        "#{attendance.leave&.strftime("%H:%M")}",
        "#{csv_attendance(attendance)}",
        "#{attendance.remark}"
        ]
      csv << column_values
    end
  end