import re
import sys
import getopt

#Memory map structure, and pass architecture inspired by https://github.com/zeckendorf/Python-MIPS-Assembler, however I implemented slightly different features with the same overall structure

instruction_table = {
	'addiu' : ['0x09','rs','rt','imm'],
	'addu'  : ['0x00','rs','rt','rd','shamt','0x21'],
	'and'   : ['0x00','rs','rt','rd','shamt','0x24'],
	'andi'  : ['0x0C','rs','rt','imm'],
	'beq'   : ['0x04','rs','rt','imm'],
	'bgez'  : ['0x01','rs','rt','imm'],
	'bgezal': ['0x01','rs','rt','imm'],
	'bgtz'  : ['0x07','rs','rt','imm'],
	'blez'  : ['0x06','rs','rt','imm'],
	'bltz'  : ['0x01','rs','rt','imm'],
	'bltzal': ['0x01','rs','rt','imm'],
	'bne'   : ['0x05','rs','rt','imm'],
	'div'   : ['0x00','rs','rt','rd','shamt','0x1A'],
	'divu'  : ['0x00','rs','rt','rd','shamt','0x1B'],
	'j'     : ['0x02', 'add'],
	'jalr'  : ['0x00','rs','rt','rd','shamt','0x09'],
	'jal'   : ['0x03', 'add'],
	'jr'    : ['0x00','rs','rt','rd','shamt','0x08'],
	'lb'    : ['0x20','rs','rt','imm'],
	'lbu'   : ['0x24','rs','rt','imm'],
	'lh'    : ['0x21','rs','rt','imm'],
	'lhu'   : ['0x25','rs','rt','imm'],
	'lui'   : ['0x0F','rs','rt','imm'],
	'lw'    : ['0x23','rs','rt','imm'],
	'lwl'   : ['0x22','rs','rt','imm'],
	'lwr'   : ['0x26','rs','rt','imm'],
	'mthi'  : ['0x00','rs','rt','rd','shamt','0x11'],
	'mtlo'  : ['0x00','rs','rt','rd','shamt','0x13'],
	'mult'  : ['0x00','rs','rt','rd','shamt','0x18'],
	'multu' : ['0x00','rs','rt','rd','shamt','0x19'],
	'or'    : ['0x00','rs','rt','rd','shamt','0x25'],
	'ori'   : ['0x0D','rs','rt','imm'],
	'sb'    : ['0x28','rs','rt','imm'],
	'sh'    : ['0x29','rs','rt','imm'],
	'sll'   : ['0x00','rs','rt','rd','shamt','0x00'],
	'sllv'  : ['0x00','rs','rt','rd','shamt','0x04'],
	'slt'   : ['0x00','rs','rt','rd','shamt','0x2A'],
	'slti'  : ['0x0A','rs','rt','imm'],
	'sltiu' : ['0x0B','rs','rt','imm'],
	'sltu'  : ['0x00','rs','rt','rd','shamt','0x2B'],
	'sra'   : ['0x00','rs','rt','rd','shamt','0x03'],
	'srav'  : ['0x00','rs','rt','rd','shamt','0x07'],
	'srl'   : ['0x00','rs','rt','rd','shamt','0x02'],
	'srlv'  : ['0x00','rs','rt','rd','shamt','0x06'],
	'subu'  : ['0x00','rs','rt','rd','shamt','0x23'],
	'sw'    : ['0x2B','rs','rt','imm'],
	'xor'   : ['0x00','rs','rt','rd','shamt','0x06'],
	'xori'  : ['0x0E','rs','rt','imm']
}

register_table = {
	'$zero' : 0,
	'$at' : 1,
	'$v0' : 2,
	'$v1' : 3,
	'$a0' : 4,
	'$a1' : 5,
	'$a2' : 6,
	'$a3' : 7,
	'$t0' : 8,
	'$t1' : 9,
	'$t2' : 10,
	'$t3' : 11,
	'$t4' : 12,
	'$t5' : 13,
	'$t6' : 14,
	'$t7' : 15,
	'$s0' : 16,
	'$s1' : 17,
	'$s2' : 18,
	'$s3' : 19,
	'$s4' : 20,
	'$s5' : 21,
	'$s6' : 22,
	'$s7' : 23,
	'$t8' : 24,
	'$t9' : 25,
	'$k0' : 26,
	'$k1' : 27,
	'$gp' : 28,
	'$sp' : 29,
	'$fp' : 30,
	'$ra' : 31
}

class assembly_parser():
	word_size = 4
	default_mem_loc = 0
	current_location = 0
	instr_table = {}
	system_memory = {}
	reg_table = {}
	output_array = []

	def __init__(self, default_memory_location, instr_table, reg_table, word_size):
		self.default_mem_loc = default_memory_location
		self.instr_table = instr_table
		self.reg_table = reg_table
		self.word_size = word_size
	
	def first_pass(self, lines):
		'''
		Cleans up and prepares the lines for parsing
		'''
		self.current = self.default_mem_loc
		for line in lines:
			#remove comments and whitespace
			if '#' in lines:
				line = line[0:line.find('#')]
			line = line.strip()
			if not len(line):
				continue

			self.fix_current_location()

			if '.end' in line:
				continue

			#make sure memory aligns with divisions of 4
			self.fix_current_location()
			
			self.current_location += 4
	
	def second_pass(self, lines):
		self.current_location = self.default_mem_loc
		for line in lines:
			if '#' in lines:
				line = line[0:line.find('#')]
			line = line.strip()
			if not(len(line)):
				continue
			self.fix_current_location()
			#align memory to word size

			instruction = line[0:line.find(' ')].strip().split(',')[0]
			args = line[line.find(' ') + 1:].replace(' ', '').split(',')

			#convert numbers into decimal
			argcount = 0
			for arg in args:
				if arg[-1] == 'H':
					args[argcount] = str(int(arg[:-1],16))
				elif arg[-1] == 'B':
					args[argcount] = str(int(arg[:-1], 2))
				argcount += 1

			if(instruction in self.instr_table.keys()):
				self.parse_instruction(instruction,args)

			#parse instructions to exit
			instruction = line[0:line.find(' ')].strip()
			if not instruction:
				continue
	
	def parse_instruction(self, instruction, raw_args):
		#parses instructions into hex
		machine_code = self.instr_table[instruction]
		arg_count = 0
		offset = 'not_valid'
		args = raw_args
		for arg in args:
			if ('(' in arg):
				#parse offset from known syntax
				offset = hex(int(arg[0:arg.find('(')]))
				register = re.search('\((.*)\)',arg)

				#deal with offsets
				location = self.reg_table[register.group(1)]
				register = location

				#process args
				args[arg_count] = register
			if(arg in self.reg_table.keys()):
				#replace reg symbol with value in table
				args[arg_count] = int(self.reg_table[arg])
			arg_count += 1
		
		#memory parsing for branch and jump instructions
		if (instruction == 'j' or instruction == 'jal' or instruction == 'jalr' or instruction == 'jr'):
			args[0] = str(int(args[0])/4)
		for i in range(0,len(args)):
			args[i] = str(hex(int(args[i])))

		#R-type instruction
		if len(machine_code) == 6:
			#initial r values
			rs = '0'
			rt = '0'
			rd = '0'

			#if jr type instruction
			if len(args) == 1:
				rs = args[0]
			else:
				rs = args[1]
				rt = args[2]
				rd = args[0]
			
			machine_code[1] = rs
			machine_code[2] = rt
			machine_code[3] = rd
			machine_code[4] = '0'

			#get binary of machine code
			op_bin = self.hex2bin(machine_code[0],6)
			rs_bin = self.hex2bin(machine_code[1],5)
			rt_bin = self.hex2bin(machine_code[2],5)
			rd_bin = self.hex2bin(machine_code[3],5)
			shamt_bin = "00000"
			funct_bin = self.hex2bin(machine_code[5],6)

			#32 bit string
			bit_string = op_bin + rs_bin + rt_bin + rd_bin + shamt_bin + funct_bin
			self.store_bit_string(bit_string,instruction,raw_args)

			return
		
		#I-type instruction
		if len(machine_code) == 4:
			#set rs, rt, imm in the machine_code
			rs = args[1]
			rt = args[0]
			imm = offset

			#is this one of the andi/addi no offset immediate syntaxes
			if len(args) == 3:
				imm = hex(int(args[2],16))

			elif imm is 'not_valid':
				imm = args[1]
				rs = '0'

			machine_code[1] = rs
			machine_code[2] = rt
			machine_code[3] = imm

			#get binaries again
			op_bin = self.hex2bin(machine_code[0],6)
			rs_bin = self.hex2bin(machine_code[1],5)
			rt_bin = self.hex2bin(machine_code[2],5)
			im_bin = self.hex2bin(machine_code[3],16)

			#32 bit string
			bit_string = op_bin + rs_bin + rt_bin + im_bin
			self.store_bit_string(bit_string,instruction,raw_args)
			return
		
		#J-type instruction
		if len(machine_code) == 2:

			#create hex code
			address = args[0]
			machine_code[1] = hex(int(address,16))

			#produce bit string
			op_bin = self.hex2bin(machine_code[0],6)
			address_bin = self.hex2bin(machine_code[1], 26)
			#store bit string in memory
			bit_string = op_bin + address_bin
			self.store_bit_string(bit_string,instruction,raw_args)

			return
		
		return
	
	def hex2bin(self,hex_val,num_bits):
		#return binary string of num_bits length of hex value (pos or neg)

		#perform two's comp
		tc = False
		if '-' in hex_val:
			tc = True
			hex_val = hex_val.replace('-', '')
		
		bit_string = '0' * num_bits
		bin_val = str(bin(int(hex_val,16)))[2:]
		bit_string = bit_string[0: num_bits - len(bin_val)] + bin_val + bit_string[num_bits:]

		#2s comp if negative hex value
		if tc:
			tsubstring = bit_string[0:bit_string.rfind('1')]
			rsubstring = bit_string[bit_string.rfind('1'):]
			tsubstring = tsubstring.replace('1','X')
			tsubstring = tsubstring.replace('0','1')
			tsubstring = tsubstring.replace('X','0')
			bit_string = tsubstring + rsubstring

		return bit_string

	def bin2hex(self, bit_string):
		hex_string = str(hex(int(bit_string,2)))[2:].zfill(2)
		return hex_string

	def store_bit_string(self, bit_string, instruction, arguments):
		#store bit string into current memory block, divided into bytes
		
		if self.current_location % 4 == 0:
			self.output_array.append(hex(self.current_location)+':		0x')
		
		self.system_memory[self.current_location] = bit_string

		self.output_array[-1] += self.bin2hex(bit_string)

		self.current_location += 4

		if self.current_location % 4 == 0:
			self.output_array[-1] += '		' + instruction.ljust(5) + ', '.join(arguments)
	
	def output_memory_txt(self,title):
		txt_object = open(title,"w+")
		keylist = self.system_memory.keys()
		keylist.sort()
		for key in keylist:
			txt_object.write(str(self.system_memory[key])+"\n")

	def fix_current_location(self):
		#align memory locations with word size
		if self.current_location % self.word_size is not 0:
			self.current_location += self.word_size - self.current_location % self.word_size

def usage():
	print("Usage: " + sys.argv[0] + " -i <file1> <file2>")
	sys.exit(1)

def main(argv):
	files = argv
	if len(files) is not 2:
		usage()
	
	asm = open(files[0])
	lines = asm.readlines()
	parser = assembly_parser(3217031168, instruction_table, register_table,4) #3217031168 is 0xBFC00000
	parser.first_pass(lines)
	parser.second_pass(lines)
	parser.output_memory_txt(files[1])

if(__name__ == '__main__'):
	main(sys.argv[1:])