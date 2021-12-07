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
    logic [3:0] mem_byteenable; // OUTPUT
    logic [31:0] mem_writedata; // OUTPUT
    logic [31:0] mem_address; // OUTPUT

    logic waitrequest;
    logic mem_writeenable; // OUTPUT
    logic mem_readenable; // OUTPUT

    initial begin
        $dumpfile("load_store.vcd");
        $dumpvars(0, load_store_tb);
        clk = 0;
        state = 2;

        #5;

        repeat (3600) begin
            #10 clk = 0;
            #10 clk = 1;

            case (state) 
                2'b00: state = 2'b01;
                2'b01: state = 2'b10;
                2'b10: state = 2'b00;
            endcase

        end

        $finish;
    end

    initial begin

        PC_in = 20;

        @ (posedge clk) $display(state);
        @ (posedge clk) $display(state);
        @ (posedge clk) $display(state);
        
        @ (posedge clk) begin

             // Fetch Instruction 20

            $display("Current State: ");
            $display(state);
            $display("Value of mem_address: ");
            $display(mem_address);

            assert(mem_address == 20);
            assert(mem_readenable == 1);

        end
        @ (posedge clk) begin

            mem_readdata = 50;
            
            lw = 1;
            rs_data = 0;
            offset = 15;
            rt = 4;

            assert(instruction_out == 50);
            assert(mem_readenable == 1);
            assert(mem_address == 15);


        end
        @ (posedge clk) begin
            
            mem_readdata = 40;

            assert(reg_writedata == 40);
            assert(reg_writeenable == 1);

        end 


    end

    load_store LS( .clk(clk), 
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
                    .offset(offset),
                    .rs_data(rs_data),
                    .rt_data(rt_data),
                    .rt(rt),
                    .reg_byteenable(reg_byteenable),
                    .reg_writeenable(reg_writeenable),
                    .reg_writedata(reg_writedata),
                    .instruction_out(instruction_out),
                    .PC_in(PC_in),
                    .mem_readdata(mem_readdata),
                    .mem_byteenable(mem_byteenable),
                    .mem_writedata(mem_writedata),
                    .mem_address(mem_address),
                    .waitrequest(waitrequest),
                    .mem_writeenable(mem_writeenable),
                    .mem_readenable(mem_readenable));


endmodule