module next_instruction_tb();
logic[31:0] r_s;
logic[31:0] r_t;
logic[15:0] I_intermidiete;
logic[25:0] J_intermidiete;
logic[31:0] PC_out;
logic STALL;
logic link;
logic state;
logic clk;
logic rst;
logic J;
logic JAL;
logic JR;
logic JALR;
logic BEQ;
logic BGEZ;
logic BGEZAL;
logic BGTZ;
logic BLEZ;
logic BLTZ;
logic BLTZAL;
logic BNE;

initial begin
    STALL = 0;
    clk = 0;
    #1
    clk = 1;
    #1
    $display("Current state %d and PC is: %d", state, (PC_out - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    $display("Current state %d and PC is: %d", state, (PC_out - 4));
    clk = 0;
    J = 1;
    J_intermidiete = 10;
    #1
    clk = 1;
    #1
    $display("Current state %d and PC is: %d", state, (PC_out - 4));
    clk = 0;
    #1
    
    clk = 1;
    #1
    $display("Current state %d and PC is: %d", state, (PC_out - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    $display("Current state %d and PC is: %d", state, (PC_out - 4));
end

next_instruction n1(
    .r_s(r_s),
    .r_t(r_t),
    .I_intermidiete(I_intermidiete),
    .J_intermidiete(J_intermidiete),
    .PC_out(PC_out),
    .STALL(STALL),
    .link(link),
    .state(state),
    .clk(clk),
    .rst(rst),
    .J(J),
    .JAL(JAL),
    .JR(JR),
    .JALR(JALR),
    .BEQ(BEQ),
    .BGEZ(BGEZ),
    .BGEZAL(BGEZAL),
    .BGTZ(BGTZ),
    .BLEZ(BLEZ),
    .BLTZ(BLTZ),
    .BLTZAL(BLTZAL),
    .BNE(BNE)
);
endmodule