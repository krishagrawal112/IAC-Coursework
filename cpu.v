module control_path(
    input logic clk,
    input logic reset,
    output logic active,
    output logic[31:0] register_v0,
    );

    logic[31:0] instruction;
    logic[5:0] Opcode;
    logic[5:0] funct;


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

    assign funct = instruction[5:0];
    assign Opcode = instruction[31:26];
    assign JType = (Opcode[5:1] == 5'b00001);
    assign RType = (Opcode = 6'b000000);
    assign IType = (!JType && !RType);
    assign JUMPType = ((JType) || (RType ==1) && (funct == 6'b001000) || (RType == 1) && (funct == 6'b001001));
    assign BRANCHType = ((Opcode == 6'b000100) || ((opcode == 6'b000001) && (rt == 5'b00001)) || ((opcode == 6'b000001) && (rt == 5'b10001)) || ((opcode == 6'b000111) && (rt == 5'b00000)) || ((opcode == 6'b000110) && (rt == 5'b00000)) || ((opcode == 6'b000001) && (rt == 5'b00000)) || ((opcode == 6'b000001) && (rt == 5'b10000)) || (opcode == 6'b000101));
    assign PCEn = (state == EXEC);
    assign IREn = (state == FETCH);
    assign AddrSrc = (state == FETCH);
    assign PCSrc1 = ((JumpAndBranchBool) == Jump || (JumpAndBranchBool == Branch));
    assign PCSrc2 = ((RType ==1) && (funct == 6'b001000) || (RType == 1) && (funct == 6'b001001));
    assign PCSrc3 = (JType);

endmodule