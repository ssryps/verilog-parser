all: mem ans

mem: test.s
	python .\generate_mem.py -i .\test.s -m test.mem
	
ans: test.s
	python .\make_answer.py -i .\test.s -o .\test.ans

clean:
	rm test.mem test.ans
	