module decode (

    input logic [31:0] instruction,
    input logic waitrequest,
    output logic STALL,

    output logic [4:0] rs,
    output logic [4:0] rt,
    output logic [4:0] rd,
    output logic [15:0] immediate,
    output logic [25:0] address,
    output logic [4:0] shamt,
    
    output logic addiu,
    output logic addu,
    output logic andr,
    output logic andi,
    output logic beq,
    output logic bgez,
    output logic bgezal,
    output logic bgtz,
    output logic blez,
    output logic bltz,
    output logic bltzal,
    output logic bne,
    output logic div,
    output logic divu,
    output logic j,
    output logic jalr,
    output logic jal,
    output logic jr,
    output logic lb,
    output logic lbu,
    output logic lh,
    output logic lhu,
    output logic lui,
    output logic lw,
    output logic lwl,
    output logic lwr,
    output logic mthi,
    output logic mtlo,
    output logic mult,
    output logic multu,
    output logic orr,
    output logic ori,
    output logic sb,
    output logic sh,
    output logic sll,
    output logic sllv,
    output logic slt,
    output logic slti,
    output logic sltiu,
    output logic sltu,
    output logic sra,
    output logic srav,
    output logic srl,
    output logic srlv,
    output logic subu,
    output logic sw,
    output logic xorr,
    output logic xori
);

logic [5:0] opcode;
logic [5:0] funct;
logic rType;

// Instruction Decomposition

assign rs = instruction[25:21]; // Base Register (Load / Store) || S1 (ALU)
assign rt = instruction[20:16]; // Target Register (Load / Store) || S2 (ALU)
assign rd = instruction[15:11]; // Desitination Register (Register Instructions Only)
assign shamt = instruction[10:6]; // Shift Amount
assign immediate = instruction[15:0]; // Immediate Value for I type
assign address = instruction[25:0]; // Address for J Type

assign rType = (opcode == 6'b000000);

// Find out what instruction is what

assign opcode = instruction[31:26];
assign funct = instruction[5:0];

assign addiu = (opcode == 6'b001001);
assign addu = ((rType == 1) && (funct == 6'b100001));
assign andr = ((rType == 1) && (funct == 6'b100100));
assign andi = (opcode == 6'b001100);
assign beq = (opcode == 6'b000100);
assign bgez = ((opcode == 6'b000001) && (rt == 5'b00001));
assign bgezal = ((opcode == 6'b000001) && (rt == 5'b10001));
assign bgtz = ((opcode == 6'b000111) && (rt == 5'b00000));
assign blez = ((opcode == 6'b000110) && (rt == 5'b00000));
assign bltz = ((opcode == 6'b000001) && (rt == 5'b00000));
assign bltzal = ((opcode == 6'b000001) && (rt == 5'b10000));
assign bne = (opcode == 6'b000101);
assign div = ((rType == 1) && (funct == 6'b011010));
assign divu = ((rType == 1) && (funct == 6'b011011));
assign j = (opcode == 6'b000010);
assign jalr = ((rType == 1) && (funct == 6'b001001));
assign jal = (opcode == 6'b000011);
assign jr = ((rType ==1) && (funct == 6'b001000));
assign lb = (opcode == 6'b100000);
assign lbu = (opcode == 6'b100100);
assign lh = (opcode == 6'b100001);
assign lhu = (opcode == 6'b100101);
assign lui = (opcode == 6'b001111);
assign lw = (opcode == 6'b100011);
assign lwl = (opcode == 6'b100010);
assign lwr = (opcode == 6'b100110);
assign mthi = ((rType == 1) && (funct == 6'b010001));
assign mtlo = ((rType == 1) && (funct == 6'b010011));
assign mult = ((rType == 1) && (funct == 6'b011000));
assign multu = ((rType == 1) && (funct == 6'b011001));
assign orr = ((rType == 1) && (funct == 6'b100101));
assign ori = (opcode == 6'b001101);
assign sb = (opcode == 6'b101000);
assign sh = (opcode == 6'b101001);
assign sll = ( (rType == 1) && (funct == 6'b000000) );
assign sllv = ( (rType == 1) && (funct == 6'b000100) );
assign slt = ( (rType == 1) && (funct == 6'b101010) );
assign slti = (opcode == 6'b001010);
assign sltiu = (opcode == 6'b001011);
assign sltu = ( (rType == 1) && (funct == 6'b101011) );
assign sra = ( (rType == 1) && (funct == 6'b000011) );
assign srav = ( (rType == 1) && (funct == 6'b000111) );
assign srl = ( (rType == 1) && (funct == 6'b000010) );
assign srlv = ( (rType == 1) && (funct == 6'b000110) );
assign subu = ( (rType == 1) && (funct == 6'b100011) );
assign sw = (opcode == 6'b101011);
assign xorr = ((rType == 1) && (funct == 6'b100110) );
assign xori = (opcode == 6'b001110);

if(waitrequest && (lb || lbu || lh || lhu || lui || lw || lwl || lwr || sw || sh || sw)) STALL = 1;
else STALL = 0;

endmodule