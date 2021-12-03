module next_instruction_tb();
logic[31:0] r_s;
logic[31:0] r_t;
logic[15:0] I_intermidiete;
logic[25:0] J_intermidiete;
logic[31:0] write_data_PC;
logic write_enable_PC;
logic STALL;
logic link;
logic[1:0] state;
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
     J = 0;
 JAL = 0;
 JR = 0;
 JALR = 0;
 BEQ = 0;
 BGEZ = 0;
 BGEZAL = 0;
 BGTZ = 0;
 BLEZ = 0;
 BLTZ = 0;
 BLTZAL = 0;
 BNE = 0;
    STALL = 0;
    clk = 0;
    #1
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    J = 1;
    J_intermidiete = 10;
    #1
    clk = 1;
    #1
    //0
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    J = 0;
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //0
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //0
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //0
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    #1
    
    clk = 0;
    
    #1
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    
    #1
    clk = 1;
    #1
    //0
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    BEQ = 1;
    r_s = 999;
    r_t = 999;
    I_intermidiete = 100;
    #1
    clk = 1;
    #1
    //1
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    clk = 1;
    #1
    //2
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));
    clk = 0;
    #1
    
    clk = 1;
    #1
    
    //0
    BEQ = 0;
    $display("Current state %d and PC is: %d", state, (write_data_PC - 4));

end

next_instruction n1(
    .r_s(r_s),
    .r_t(r_t),
    .I_intermidiete(I_intermidiete),
    .J_intermidiete(J_intermidiete),
    .write_data_PC(write_data_PC),
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
    .BNE(BNE),
    .write_enable_PC(write_enable_PC)
);
endmodule