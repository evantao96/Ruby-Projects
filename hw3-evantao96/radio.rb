class Radio
  # Continuously loops through waiting for input from the user
  # Breaks if the user types 'exit'
  # Matches the user input otherwise
  def run
    loop do
      puts "Do you want to 'add' a song, 'list' songs, or exit?"
      user_input = gets.strip
      break if user_input == 'exit'
      match_user_input user_input
    end
  end

  # Performs the appropriate behavior based on the user's input
  def match_user_input(user_input)
    case user_input
    when 'add' then Song.add
    when 'list' then Song.list
    else puts "I didn't understand that"
    end
  end
end
