module next_instruction(
    input logic[31:0] r_s,
    input logic[31:0] r_t,
    input logic[15:0] I_intermidiete,
    input logic[25:0] J_intermidiete,
    input logic STALL,
    input logic clk,
    input logic rst,
    input logic J,
    input logic JAL,
    input logic JR,
    input logic JALR,
    input logic BEQ,
    input logic BGEZ,
    input logic BGEZAL,
    input logic BGTZ,
    input logic BLEZ,
    input logic BLTZ,
    input logic BLTZAL,
    input logic BNE,
    output logic write_enable_PC,
    output logic link,
    output logic[1:0] state,
    output logic[31:0] write_data_PC
);
logic jump;
logic[31:0] jump_amount;
logic jump_addition;
assign write_data_PC = PC + 4;
reg[31:0] PC;

initial begin 
    PC = 0;
    state = 0;
end
always_comb begin
    //Determining whether to jump or not and how much
    if(J == 1) begin
        jump_amount = {6'b0, J_intermidiete}*4;
        jump = 1;
        jump_addition = 0;
    end
    else if(JAL == 1) begin
        jump_amount = {6'b0, J_intermidiete}*4;
        jump = 1;
        link = 1;
        jump_addition = 0;
    end
    else if(JR == 1)begin
        jump_amount = r_s * 4;
        jump = 1;
        jump_addition = 0;
        
        
    end
    else if(JALR == 1)begin
        jump_amount = r_s * 4;
        jump = 1;
        link = 0;
        jump_addition = 0;
    end
    else if(BEQ == 1 && r_s == r_t)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else if(BGEZ == 1 && r_s >= 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else if(BGEZAL == 1 && r_s >= 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        link = 1;
        jump_addition = 1;
    end
    else if(BGTZ == 1 && r_s > 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else if(BLEZ == 1 && r_s <= 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else if(BLTZ == 1 && r_s < 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else if(BLTZAL == 1 && r_s < 0)begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        link = 1;
        jump_addition = 1;
    end
    else if((BNE == 1) && (r_s != r_t))begin
        jump_amount = {16'h0000, I_intermidiete} * 4;
        jump =1;
        jump_addition = 1;
    end
    else begin
        jump_amount = 0;
        jump = 0;
        link = 0;
        jump_addition = 0;
    end
    if(link == 1) write_enable_PC = 1;
    else if(JALR == 1) write_enable_PC = 1;
    else write_enable_PC = 0;
 
end
always_ff @(posedge clk) begin
    if(state == 2)begin
        //EXEC 2:  JUMP or PC+4
        if(jump == 0)begin
            PC <= PC + 4;
        end
        else begin
            PC <= jump_addition ? PC + 4 + jump_amount : jump_amount;
        end
    end
    if(STALL == 0) begin
        //State logic: If stall != 0, FETCH -> EXEC1 -> EXEC2 -> FETCH
       state <= (state == 0) ? 1 : (state == 1) ? 2 : 0; 
    end
    else state <= 0;
end
endmodule