require 'roo'
require 'roo-xls'
require 'colorize'
require 'win32console'

script_path = File.dirname(__FILE__)
question_files = []
question_files << script_path + "\\Countries and capitals.xls"
#question_files << script_path + "\\Countries and GDP.xls"
#question_files << script_path + "\\Companies and gross income.xls"

selected_quiz = rand(question_files.size)
s = Roo::Excel.new(question_files[selected_quiz])

question_word = s.cell(1,1)
answer_word = s.cell(1,2)

#Randomly select question
while(true)
	q = rand(s.last_row-1)+2

	p "What is the #{answer_word} of #{s.cell(q,1)}?"

	begin
	ans = gets.chomp
	if s.cell(q,2).class == Float 
		ans = Float(ans)
	end
	
	ans_correct = false #Allow 10% tolerance for numerical answers
	unless ans.nil?
		if (ans == s.cell(q,2) || (s.cell(q,2).class == Float && (ans-s.cell(q,2)).abs/s.cell(q,2).abs <= 0.1 ))
			ans_correct = true
		end
	end
	
	if (ans_correct)
		puts "True".green
	else
		if(ans =="")
			puts "a: #{s.cell(q,2)}".yellow
		else
			puts "False, a: #{s.cell(q,2)}".red
		end
	end

	rescue ArgumentError
		puts 'Input error'.red
	end
end

