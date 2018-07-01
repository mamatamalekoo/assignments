module YesNo
  def yncheck(question)
    response = gets.chomp.downcase
    array = ["y","n"]
    until array.include?(response)
      print "\nSorry! I didn't quite get that. #{question}"
      response = gets.chomp.downcase
    end
    return response
  end
end
