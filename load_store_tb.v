module load_store_tb();

    // Base Control

    logic clk;
    logic [1:0] state;

    // Decoded Instruction

    logic lb;
    logic lbu;
    logic lh;
    logic lhu;
    logic lui;
    logic lw;
    logic lwl;
    logic lwr;
    logic sb;
    logic sh;
    logic sw;

    logic [15:0] offset;
    logic [31:0] rs_data;
    logic [31:0] rt_data;
    logic [4:0] rt;

    // Write Back Control

    logic [3:0] reg_byteenable; // OUTPUT
    logic reg_writeenable; // OUTPUT
    logic [31:0] reg_writedata; // OUTPUT

    logic [31:0] instruction_out; // OUTPUT
    logic [31:0] PC_in;

    // Avalon

    logic [31:0] mem_readdata; // OUTPUT
    logic [31:0] mem_byteenable; // OUTPUT
    logic [31:0] mem_writedata; // OUTPUT
    logic [31:0] mem_address;

    logic waitrequest;
    logic mem_writeenable; // OUTPUT
    logic mem_readenable; // OUTPUT

    initial begin
        



    end

    task runAsserts (input logic [3:0] er_byte_enable, 
                    input logic er_writeenable, 
                    input logic [31:0] er_writedata, 
                    input logic [31:0] einstruction_out,
                    input logic [31:0] em_readdata,
                    input logic [31:0] em_byteenable,
                    input logic [31:0] em_writedata,
                    input logic em_writeenable,
                    input logic em_readenable );
        begin
            
            


        end
    endtask


    load_store LS( clk, 
                    state, 
                    lb, 
                    lbu, 
                    lh, 
                    lhu, 
                    lui, 
                    lw, 
                    lwl, 
                    lwr, 
                    sb, 
                    sh, 
                    sw, 
                    offset,
                    rs_data,
                    rt_data,
                    rt,
                    reg_byteenable,
                    reg_writeenable,
                    reg_writedata,
                    instruction_out,
                    PC_in,
                    mem_readdata,
                    mem_byteenable,
                    mem_writedata,
                    mem_readdata,
                    waitrequest,
                    mem_writeenable,
                    mem_readenable);


endmodule