require 'csv'
@students = [] #an empty array accessible to all methods


def interactive_menu
 loop do
   print_menu
   process(STDIN.gets.chomp)
  end
end


def show_students
  print_header
  print_students_list
  print_footer
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.strip
  #Exercise 8.7
  puts "Enter cohort"
  cohort = STDIN.gets.strip.to_sym
  #Exercise 8.5
  puts "Enter hobbies"
  hobbies = STDIN.gets.strip
  puts "Enter country of birth"
  country = STDIN.gets.strip
  #while the name is not empty, repeat this code
  while !name.empty? && !cohort.empty? do
    #add the student hash to the array
    #@students << {name: name, cohort: cohort, hobbies: hobbies, country: country}
    populate_student({name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country})
      #Exercise 8.9
      if @students.count == 1
    puts "Now we have #{@students.count} student"
      else
      puts "Now we have #{@students.count} students"
      end
    # get another name from the user
    name = STDIN.gets.strip
      puts "Enter cohort"
    cohort = STDIN.gets.strip.to_sym unless name.empty?
      puts "Enter hobbies"
    hobbies = STDIN.gets.strip unless name.empty?
      puts "Enter country of birth" 
    country = STDIN.gets.strip unless name.empty?
  end
  #return the array of students
  @students
end

#Exercise 8.6  
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

#Exercise 8.1, 8.4
def print_students_list
  if @students.empty?
    puts "There are no students"
  else
  counter = 0
    while counter < @students.count  
      puts "#{counter+1} #{@students[counter][:name]} (#{@students[counter][:cohort]} cohort) 
      likes to play #{@students[counter][:hobbies]} and is from #{@students[counter][:country]} ".center(50)
      counter += 1
    end
  end
end

#Exercise 8.2
def print_specific_letter
  puts "User enters a letter to filter"
  letter = gets.strip
  @students.select do |student|
    puts student[:name] if student[:name].start_with?(letter)
  end
end

#Exercise 8.3
def print_less
   @students.select do |student|
    puts student[:name] if student[:name].length < 12
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

#Exercise 8.8
def print_cohort_group(students)
  puts "Enter cohort"
  students_group = []
  cohort_group = gets.strip.to_sym
  @students.map do |student|
    if student[:cohort] == cohort_group
      students_group << student
    end
  end
puts students_group
end


def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
end



def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
  end
end



def save_students
  puts "What file would you like to save?"
  filename = gets.chomp
  #open the file for writing
  CSV.open("#{filename}.csv", "wb") do |csv|
  #iterate over the array of students
  @students.each do |student|
    csv << [student[:name], student[:cohort], student[:hobbies], student[:country]]
  end
  puts "File successfully saved"
end
end


def load_students(filename = "students.csv")
  puts "Which file would you like to load?"
  filename = gets.chomp
  filename = "students" if filename.to_s.empty?
  CSV.open("#{filename}.csv", "r")
  CSV.foreach("#{filename}.csv")  do |line|
    name, cohort, hobbies, country = line
    populate_student({name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country})
  end
  puts "File successfully loaded"
end


def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method i it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit #quit the program
  end
end


def populate_student(student_details = {})
  @students << student_details
end


def print_source_code
  File.open(__FILE__, "r") do |file|
    file.readlines.each do |line|
      puts line
    end
  end
end

try_load_students
interactive_menu

print_source_code