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

    parameter MAX_CYCLES = 1000;

    initial begin
        
        $dumpfile("load_store.vcd");
        $dumpvars(0, load_store_tb);

        clk = 0;
        state = 0;

        repeat (MAX_CYCLES) begin
            #10; clk = 1;
            case(state)
                2'b00: state = 2'b01;
                2'b01: state = 2'b10;
                2'b10: state = 2'b00;
                default: state = 2'b00;
            endcase 
            #10; clk = 0;
        end

        $fatal(2, "Simulation Time-Out");

    end

    initial begin 

        // LW Test

        PC_in <= 20;

        @ (posedge clk); // 0->1

        assert(mem_address == 20); 
        assert(mem_readenable == 1);

        mem_readdata <= 50;
        lw <= 1;
        rs_data <= 0;
        offset <= 12;

        @ (posedge clk); // 1->2

        assert(instruction_out == 50); 
        assert(mem_readenable == 1); 
        assert(mem_address == 12); 
        
        mem_readdata <= 40;

        @ (posedge clk); //2->0

        assert(reg_writedata == 40);
        assert(reg_writeenable == 1);

        resetVars();

        //LH Test

        PC_in <= 21;

        @ (posedge clk); // 0->1

        assert(mem_address == 21); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10000100000100000000000000000000;
        lh <= 1;
        rs_data <= 0;
        offset <= 18;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10000100000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9876543;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'hfffff987);
        assert(reg_writeenable == 1);

        resetVars();

        //LHU Test

        PC_in <= 22;

        @ (posedge clk); // 0->1

        assert(mem_address == 22); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10010100000100000000000000000000;
        lhu <= 1;
        rs_data <= 0;
        offset <= 18;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10010100000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9876543;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'h0000f987);
        assert(reg_writeenable == 1); 

        resetVars();

        //LB Test

        PC_in <= 23;

        @ (posedge clk); // 0->1

        assert(mem_address == 23); // emem_addr0
        assert(mem_readenable == 1);
        mem_readdata <= 32'b10000000000100000000000000000000;
        lb <= 1;
        rs_data <= 0;
        offset <= 17;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10000000000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9879563;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'hffffff95);
        assert(reg_writeenable == 1); 

        resetVars();

        //LBU Test

        PC_in <= 24;

        @ (posedge clk); // 0->1

        assert(mem_address == 24); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10010000000100000000000000000000;
        lbu <= 1;
        rs_data <= 0;
        offset <= 17;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10010000000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9879563;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'h00000095);
        assert(reg_writeenable == 1);

        resetVars();

        //LWL Test
        
        PC_in <= 25;

        @ (posedge clk); // 0->1

        assert(mem_address == 25); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10001000000100000000000000000000;
        lwl <= 1;
        rs_data <= 0;
        rt_data <= 32'hfedcba98;
        offset <= 17;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10001000000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9879563;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'h9563ba98);
        assert(reg_writeenable == 1);

        resetVars();

        //LWR Test
        
        PC_in <= 26;

        @ (posedge clk); // 0->1

        assert(mem_address == 26); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10011000000100000000000000000000;
        lwr <= 1;
        rs_data <= 0;
        rt_data <= 32'hFF0000FF;
        offset <= 19;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10011000000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9879563;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'hff0000f9);
        assert(reg_writeenable == 1);

        resetVars();

        //LUI Test

        PC_in <= 27;

        @ (posedge clk); // 0->1

        assert(mem_address == 27); // emem_addr0
        assert(mem_readenable == 1);

        mem_readdata <= 32'b10010000000100000000000000000000;
        lui <= 1;
        rs_data <= 0;
        rt_data <= 32'hFF0000FF;
        offset <= 16'hf1e2;

        @ (posedge clk); // 1->2

        assert(instruction_out == 32'b10010000000100000000000000000000); // einstout
        assert(mem_readenable == 1); // emem_readen
        //assert(mem_address == 16); // emem_addr1
        
        mem_readdata <= 32'hf9879563;

        @ (posedge clk); //2->0

        assert(reg_writedata == 32'hf1e20000);
        assert(reg_writeenable == 1);

        resetVars();
        
        //SW Test

        PC_in <= 28;

        @ (posedge clk); // 0->1

        assert(mem_address == 28); 
        assert(mem_readenable == 1);

        mem_readdata <= 50;
        sw <= 1;
        rs_data <= 4;
        rt_data = 27;
        offset <= 40;

        @ (posedge clk); // 1->2

        assert(instruction_out == 50); 
        assert(mem_readenable == 0); 
        assert(mem_writeenable == 1); 
        assert(mem_address == 44); 
        assert(mem_writedata == 27);

        @ (posedge clk); //2->0

        assert(reg_writeenable == 0);

        resetVars();


        //SH Test
        PC_in <= 29;

        @ (posedge clk); // 0->1

        assert(mem_address == 29); 
        assert(mem_readenable == 1);

        mem_readdata <= 50;
        sh <= 1;
        rs_data <= 6;
        rt_data = 32'h12345678;
        offset <= 40;

        @ (posedge clk); // 1->2

        assert(instruction_out == 50); 
        assert(mem_readenable == 0); 
        assert(mem_writeenable == 1); 
        assert(mem_address == 44); 
        assert(mem_writedata == 32'h56780000);
        assert(mem_byteenable == 4'b1100);

        @ (posedge clk); //2->0

        assert(reg_writeenable == 0);

        resetVars();
        
        //SB Test
        PC_in <= 30;

        @ (posedge clk); // 0->1

        assert(mem_address == 30); 
        assert(mem_readenable == 1);

        mem_readdata <= 50;
        sb <= 1;
        rs_data <= 7;
        rt_data = 32'h12345678;
        offset <= 40;

        @ (posedge clk); // 1->2

        assert(instruction_out == 50); 
        assert(mem_readenable == 0); 
        assert(mem_writeenable == 1); 
        assert(mem_address == 44); 
        assert(mem_writedata == 32'h78000000);
        assert(mem_byteenable == 4'h8);

        @ (posedge clk); //2->0

        assert(reg_writeenable == 0);

        resetVars();

        @ (posedge clk); // BUFFER
        @ (posedge clk); // BUFFER
        @ (posedge clk); // BUFFER

        $display("All Tests Complete");
        $finish;

    end

    task resetVars;
         begin
            
            lb <= 0;
            lbu <= 0;
            lh <= 0;
            lhu <= 0;
            lui <= 0;
            lw <= 0;
            lwl <= 0;
            lwr <= 0;
            sb <= 0;
            sh <= 0;
            sw <= 0;

            offset <= 0;
            rs_data <= 0;
            rt_data <= 0;
            rt <= 0;

            mem_readdata <= 0;
            waitrequest <= 0;

         end
    endtask

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