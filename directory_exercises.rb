def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  #Exercise 8.7
  puts "Enter cohort"
  cohort = gets.chomp.to_sym
  #Exercise 8.5
  puts "Enter hobbies"
  hobbies = gets.chomp
  puts "Enter country of birth"
  country = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? && !cohort.empty? do
    #add the student hash to the array
    students << {name: name, cohort: cohort, hobbies: hobbies, country: country}
      #Exercise 8.9
      if students.count == 1
    puts "Now we have #{students.count} student"
      else
      puts "Now we have #{students.count} students"
      end
    # get another name from the user
    name = gets.chomp
      puts "Enter cohort"
    cohort = gets.chomp.to_sym
      puts "Enter hobbies"
    hobbies = gets.chomp
      puts "Enter country of birth"
    country = gets.chomp
  end
  #return the array of students
  students
end

#Exercise 8.6  
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

#Exercise 8.1, 8.4
def print(students)
  counter = 0
  while counter < students.count  
    puts "#{counter+1} #{students[counter][:name]} (#{students[counter][:cohort]} cohort)".center(50)
    counter += 1
  end
end

#Exercise 8.2
def print_specific_letter(students)
  puts "User enters a letter to filter"
  letter = gets.chomp
  students.select do |student|
    puts student[:name] if student[:name].start_with?(letter)
  end
end

#Exercise 8.3
def print_less(students)
   students.select do |student|
    puts student[:name] if student[:name].length < 12
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
