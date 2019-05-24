require 'benchmark'

def file_fetcher (method)	#Read file line by line and send each line to calling method

	total_sentance=0
	File.open('words.txt').each_line do  |line| #text file which the user want to analyse
		 method.call(line)
	end
end

def line_counter	#counts number of line in the file
			
	number_of_lines=0
	line_count_proc = Proc.new { |line| number_of_lines+=1;} # calculates the number of lines. it will be passed as argument
	file_fetcher(line_count_proc) # sending proc as argument
	puts "Total number of line in the file is #{number_of_lines}"
	return number_of_lines

end

def word_counter	#counts number of words in the file
	number_of_words = 0
	word_count_proc = Proc.new {|line| number_of_words += line.count(' ')}
	file_fetcher(word_count_proc)
	puts "Total number of words in the file #{number_of_words}"	
	return number_of_words
	
end

def sentence_counter	#Counts the number of sentances in the file

	number_of_sentances = 0
	sentance_count_proc = Proc.new { |line| number_of_sentances += line.count('.?') }
	file_fetcher(sentance_count_proc)
	puts "total number of sentances in the file  #{number_of_sentances}"
	return number_of_sentances
end

def average_sentance_line 	#Calculates the averave number of sentances in the file

	total_lines = line_counter  #calls line counter method and gets the value
	total_sentance = sentence_counter  #calls the sentance counter and gets the value
	average_sentance = total_sentance / total_lines
	puts "The average sentances per line is #{average_sentance}"
	return average_sentance
end

def average_word_line	# Calculates the average number of words in the 

	total_lines = line_counter
	total_word = word_counter
	average_words = total_word / total_lines
	puts "The average word per line is #{average_words}"
	return average_words	
end

#Method calls
# remove the # of the required method

time = Benchmark.measure{      #monitors the time of exection 

line_counter
#word_counter
#sentence_counter
#average_sentance_line
#average_word_line

}

#-----------------------------------------------------------------------------------------------------------
#ptint the exucution time and memory usage
puts time.real
puts 'RAM USAGE: ' + `pmap #{Process.pid}| tail -1`[10,40].strip
