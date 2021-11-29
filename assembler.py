import re

#Heavily inspired by https://github.com/zeckendorf/Python-MIPS-Assembler, however I implemented slightly different features with the same overall structure

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

class assembly_parser(object):
	word_size = 4
	default_mem_loc = 0
	symbol_table = {}
	current_location = 0
	instr_table = {}
	system_memory = {}
	reg_table = {}

	def init(self, default_memory_location, instruction_table, reg_table, pseudoinstruction_table, word_size):
		self.default_mem_loc = default_memory_location
		self.instr_table = instruction_table
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

			#parse instruction and arguments separately
			instruction = line[0:line.find(' ')]
			args  = line[line.find(' ') + 1:].replace(' ', '').split(',')
			if not instruction:
				continue
			
			#convert numbers into decimal
			argcount = 0
			for arg in args:
				if arg not in symbol_table.keys():
					if arg[-1] == 'H':
						args[argcount] = str(int(arg[:-1],16))
					elif arg[argcount] == 'B':
						args[argcount] = str(int(arg[:-1], 2))
				argcount += 1
	
	