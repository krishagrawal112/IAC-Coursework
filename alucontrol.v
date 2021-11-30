module ALUControl(
	ALU_Control, 
	ALUOp, 
	Function
	);  
	output reg[2:0] ALU_Control;  
	input [1:0] OPSel;  
	input [5:0] FunctionCode; //From IR[5:0]  
	wire [7:0] ALUControlIn;  
	assign ALUControlIn = {ALUOp,FunctionCode};  
	always @(ALUControlIn)  
		casex (ALUControlIn)  
			8'b00xxxxxx : ALU_Control = 3'b010;  
			8'bx1xxxxxx : ALU_Control = 3'b110;  
			8'b1xxx0000 : ALU_Control = 3'b010;  
			6'b1xxx0010 : ALU_Control = 3'b110;  
			6'b1xxx0100 : ALU_Control = 3'b000;  
			6'b1xxx0101 : ALU_Control = 3'b001;  
			6'b1xxx1010 : ALU_Control = 3'b111;   
			default: ALU_Control = 3'b010;  
	endcase  
endmodule