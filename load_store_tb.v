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

    logic [31:0] mem_readdata; 
    logic [31:0] mem_byteenable; // OUTPUT
    logic [31:0] mem_writedata; // OUTPUT
    logic [31:0] mem_address; // OUTPUT

    logic waitrequest;
    logic mem_writeenable; // OUTPUT
    logic mem_readenable; // OUTPUT

    initial begin
        $dumpfile("load_store.vcd");
        $dumpvars(0, load_store_tb);
        clk = 0;

        #5;

        repeat (3600) begin
            #10 clk = !clk;
        end

        $finish;
    end
    
    initial begin

        state = 2'b00;
        
        repeat(1800) begin
            
            @ (posedge clk)
            case (state) 
                2'b00: state = 2'b01;
                2'b01: state = 2'b10;
                2'b10: state = 2'00;
            endcase

        end



    end

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