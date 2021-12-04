module mips_cpu_bus(
        input logic clk,
        input logic reset,
        output logic active,
        output logic[31:0] register_v0,

        input logic waitrequest,
        input logic [31:0] readdata,
        output logic [31:0] address,
        output logic write,
        output logic read,
        output logic [31:0] writedata,
        output logic [3:0] byteenable
        
    );
//Internal wires
    logic[1:0] state; 
    logic [31:0] instruction;
    logic [4:0] rs;
    logic [4:0] rt;
    logic [4:0] rd;
    logic [15:0] immediate;
    logic [25:0] address;
    logic [4:0] shamt;
    logic[31:0] PC;
    
    logic write_enable_ld;
    logic write_enable_ALU;
    logic write_enable_PC;
    logic link;
    logic[31:0] write_data_ld;
    logic[31:0] write_data_ALU;
    logic[31:0] write_data_PC;
    logic[31:0] data_rs;
    logic[31:0] data_rt;
    logic[3:0] byteenable_ld;


    //Instruction wires
    logic addiu;
     logic addu;
     logic andr;
     logic andi;
     logic beq;
     logic bgez;
     logic bgezal;
     logic bgtz;
     logic blez;
     logic bltz;
     logic bltzal;
     logic bne;
     logic div;
     logic divu;
     logic j;
     logic jalr;
     logic jal;
     logic jr;
     logic lb;
     logic lbu;
     logic lh;
     logic lhu;
     logic lui;
     logic lw;
     logic lwl;
     logic lwr;
     logic mthi;
     logic mtlo;
     logic mult;
     logic multu;
     logic orr;
     logic ori;
     logic sb;
     logic sh;
     logic sll;
     logic sllv;
     logic slt;
     logic slti;
     logic sltiu;
     logic sltu;
     logic sra;
     logic srav;
     logic srl;
     logic srlv;
     logic subu;
     logic sw;
     logic xorr;
     logic xori;
    
//DECODE----------------------------------------------------------------------------------------
 

     
    
     

     decode d1(.instruction(instruction),

     .rs(rs),
     .rt(rt),
     .rd(rd),
     .immediate(immediate),
     .address(address),
     .shamt(shamt),
    
     .addiu(addiu),
     .addu(addu),
     .andr(andr),
     .andi(andi),
     .beq(beq),
     .bgez(bgez),
     .bgezal(bgezal),
     .bgtz(bgtz),
     .blez(blez),
     .bltz(bltz),
     .bltzal(bltzal),
     .bne(bne),
     .div(div),
     .divu(divu),
     .j(j),
     .jalr(jalr),
     .jal(jal),
     .jr(jr),
     .lb(lb),
     .lbu(lbu),
     .lh(lh),
     .lhu(lhu),
     .lui(lui),
     .lw(lw),
     .lwl(lwl),
     .lwr(lwr),
     .mthi(mthi),
     .mtlo(mtlo),
     .mult(mult),
     .multu(multu),
     .orr(orr),
     .ori(ori),
     .sb(sb),
     .sh(sh),
     .sll(sll),
     .sllv(sllv),
     .slt(slt),
     .slti(slti),
     .sltiu(sltiu),
     .sltu(sltu),
     .sra(sra),
     .srav(srav),
     .srl(srl),
     .srlv(srlv),
     .subu(subu),
     .sw(sw),
     .xorr(xorr),
     .xori(xori)

     );
// REGFILE ------------------------------------------------------------------------------------------------------------------------
     
regfile r1(
    .clk(clk),
    .rst(reset),
    .addr_rs(rs),
    .addr_rt(rt),
    .addr_rd(rd),
    .write_enable_ALU(write_enable_ALU),
    .write_enable_ld(write_enable_ld),
    .write_enable_PC(write_enable_PC),
    .read_addr_2(data_rt)
    .read_data_1(data_rs),
    .write_data_ALU(write_data_ALU),
    .write_data_ld(write_data_ld),
    .write_data_PC(write_data_PC),
    .link(link),
    .byteeenable_ld(byteeenable_ld),
    .v0(register_v0)
);

//NEXTINSTRUCTION------------------------------------------------------------------------------------------------------------------------
   
next_instruction NXT(
    .r_s(data_rs),
    .r_t(data_rt),
    .I_intermidiete(immediate),
    .J_intermidiete(address),
    .STALL(waitrequest),
    .clk(clk),
    .rst(reset),
    .J(j),
    .JAL(jal),
    .JR(jr),
    .JALR(jalr),
    .BEQ(beq),
    .BGEZ(bgez),
    .BGEZAL(bgzal),
    .BGTZ(bgtz),
    .BLEZ(blez)
    .BLTZAL(bltzal)
    .BNE(bne)
    .write_enable_PC(write_enable_PC)
    .link(link)
    .state(state),
    .write_data_PC(write_data_PC),
    .PC_out(PC)
);

//ALU------------------------------------------------------------------------------------------------------------------------------------

    logic[31:0] datalo;
    logic[31:0] datahi;
ALU a1(
    .immediate(immediate),
    .Rsdata(data_rs),
    .Rtdata(data_rt),
    .Rtsigned(data_rt),
    .sa(shamt),
    .addiu(addiu),
    .addu(addu),
    .andr(andr),
    .andi(andi),
    .divu(divu),
    .div(div),
    .multu(multu),
    .mult(mult),
    .orr(orr),
    .ori(ori),
    .sll(sll),
    .sllv(sllv),
    .subu(subu),
    .xorr(xorr),
    .xori(xori),
    .sra(sra),
    .srav(srav),
    .srl(srl),
    .srlv(srlv),
    .slt(slt),
    .slti(slti),
    .sltu(sltu),
    .sltiu(sltiu),
    .reg_writeenable(write_enable_ALU),
    .data(write_data_ALU),
    .datalo(datalo),
    .datahi(datahi)
);
//LOADSTORE-------------------------------------------------------------------------------------------------------------------------------

load_store l1(
    .clk(clk),
    .state(state),
    .lb(lb),
    .lbu(lbu),
    .lh(lh),
    .lhu(lhu),
    .lui(lui),
    .lw(lw),
    .lwl(lwl),
    .lwr(lwr),
    .sb(sb),
    .sh(sh),
    .sw(sw),
    .offset(immediate),
    .rs_dat(data_rs),
    .rt_data(data_rt),
    .rt(rt),
    .reg_byteenable(byteenable_ld),
    .reg_writeenable(write_enable_ld),
    .reg_writedata(write_data_ld),
    .instruction_out(instruction),
    .PC_in(PC),
    .mem_readdata(readdata),
    .mem_byteenable(byteenable),
    .mem_writedata(writedata),
    .mem_address(address),
    .waitrequest(waitrequest),
    .mem_writeenable(write),
    .mem_readenable(read)
);

/*
    logic[31:0] instruction;
    logic[5:0] Opcode;
    logic[5:0] funct;
    logic[1:0] ExtSel;
    logic[1:0] OpSel;
    logic[31:0] WBMuxOut;
    logic[31:0] RefFileOut1;
    logic[31:0] RefFileOut2;
    */




    

    /*assign Opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign immediate = instruction[15:0];
    */
    /*
    assign funct = instruction[5:0];
    assign JType = (Opcode[5:1] == 5'b00001);
    assign RType = (Opcode = 6'b000000);
    assign IType = ((!JType) && (!RType));
    assign JUMPType = ((JType) || (RType ==1) && (funct == 6'b001000) || (RType == 1) && (funct == 6'b001001));
    assign BRANCHType = ((Opcode == 6'b000100) || ((Opcode == 6'b000001) && (rt == 5'b00001)) || ((Opcode == 6'b000001) && (rt == 5'b10001)) || ((Opcode == 6'b000111) && (rt == 5'b00000)) || ((Opcode == 6'b000110) && (rt == 5'b00000)) || ((Opcode == 6'b000001) && (rt == 5'b00000)) || ((Opcode == 6'b000001) && (rt == 5'b10000)) || (Opcode == 6'b000101));
    assign PCEn = (state == EXEC);
    assign IREn = (state == FETCH);
    assign AddrSrc = (state == FETCH);
    assign PCSrc1 = ((JumpAndBranchBool) == Jump || (JumpAndBranchBool == Branch));
    assign PCSrc2 = ((RType ==1) && (funct == 6'b001000) || (RType == 1) && (funct == 6'b001001));
    assign PCSrc3 = (JType);
    //RegDst not finished
    assign RegDst = (Opcode == 6'b000011);
    assign UnsignedOps = ((opcode == 6'b001001)||((rType == 1) && (funct == 6'b100001))||((rType == 1) && (funct == 6'b011011))||(opcode == 6'b100100)||(opcode == 6'b100101)||((rType == 1) && (funct == 6'b011001))||(opcode == 6'b001011)||( (rType == 1) && (funct == 6'b101011) )||( (rType == 1) && (funct == 6'b100011) ));
    assign ExtSel[1] = (JType);
    assign ExtSel[0] = (UnsignedOps); 
    assign OpSel = (RType) ? 2'b10 :  (BRANCHType ?  2'b01 : 2'b00);
    //2'b00 if load/store must fix
    assign BSrc = (RType);
    //if BSrc is 1(RType), rd2 goes through multiplexer, if its 0(IType) ImmExt goes through)

*/
    /*
    TO-DO:
        Please figure out and write the logic for the RegWrite, MemWrite and WBSrc enable signals
    */
    /*
    assign RegWrite;
    assign MemWrite;
    assign WBSrc; //writeback selector as 3 input multiplexer

    always_ff @(PCEn) begin
        PC <= output_of_muxPC1;
    end

    assign PCNext;

    always @() begin
        case(PCSrc2)
            1'b0 : mux2_output <= rd1;
            1'b1 : mux2_output <= mux3_output;
        endcase
    end 

    always @() begin
        PCNext <= PC + 4;
        case(PCSrc1)
            1'b0 : mux1_output <= PCNext;
            1'b1 : mux1_output <= mux2_output;
        endcase
    end


    regfile regfile(clk, reset, rs, rt, RegWrite, rd, WBMuxOut, RegFileOut1, RefFileOut2);*/
    
endmodule