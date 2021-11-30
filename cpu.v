module control_path(
    input logic clk,
    input logic reset,
    output logic active,
    output logic[31:0] register_v0,
    );

    logic[31:0] instruction;
    logic[5:0] Opcode;
    logic[5:0] funct;
    logic[1:0] ExtSel;
    logic[1:0] OpSel;
    reg[31:0] PC;
    logic[31:0] WBMuxOut;
    logic[31:0] RefFileOut1;
    logic[31:0] RefFileOut2;

    initial begin
        state = 0;
    end


    typedef enum logic{
        FETCH = 1'b0;
        EXEC = 1'b1;
    } state;
    

//implements state machine 
    always_ff @(posedge clk) begin
        
        if (state == 0)begin
            state <= 1;
        end
        else begin
            state <= 0;
        end

    end

    assign Opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign immediate = instruction[15:0];
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
    assign RegDst = (Opcode == 6'b000011);
    assign UnsignedOps = ((opcode == 6'b001001)||((rType == 1) && (funct == 6'b100001))||((rType == 1) && (funct == 6'b011011))||(opcode == 6'b100100)||(opcode == 6'b100101)||((rType == 1) && (funct == 6'b011001))||(opcode == 6'b001011)||( (rType == 1) && (funct == 6'b101011) )||( (rType == 1) && (funct == 6'b100011) ));
    assign ExtSel[1] = (JType);
    assign ExtSel[0] = (UnsignedOps); 
    assign OpSel = (RType) ? 2'b10 :  (BRANCHType ?  2'b01 : 2'b00);
    //2'b00 if load/store must fix
    assign BSrc = (RType);
    //if BSrc is 1(RType), rd2 goes through multiplexer, if its 0(IType) ImmExt goes through)


    /*
    TO-DO:
        Please figure out and write the logic for the RegWrite, MemWrite and WBSrc enable signals
    */
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


    regfile regfile(clk, reset, rs, rt, RegWrite, rd, WBMuxOut, RegFileOut1, RefFileOut2);
    
endmodule