module decode (

    input logic [31:0] instruction,

    output logic [4:0] rs,
    output logic [4:0] rt,
    output logic [4:0] rd,
    output logic [15:0] immediate,
    output logic [31:0] address,
    output logic [4:0] shamt,
    
    output logic addi;
    output logic add;
    output logic and;
    output logic andi;
    output logic beq;
    output logic bgez;
    output logic bgezal;
    output logic bgtz;
    output logic blez;
    output logic bltz;
    output logic bltzal;
    output logic bne;
    output logic div;
    output logic divu;
    output logic j;
    output logic jalr;
    output logic jal;
    output logic jr;
    output logic lb;
    output logic lbu;
    output logic lh;
    output logic lhu;
    output logic lui;
    output logic lw;
    output logic lwl;
    output logic lwr;
    output logic mthi;
    output logic mtlo;
    output logic mult;
    output logic multu;
    output logic or;
    output logic ori;
    output logic sb;
    output logic sh;
    output logic sll;
    output logic sllv;
    output logic slt;
    output logic slti;
    output logic sltiu;
    output logic sltu;
    output logic sra;
    output logic srav;
    output logic srl;
    output logic srlv;
    output logic subu;
    output logic xor;
    output logic xori;
);
    

    
always_comb begin
    
end



endmodule