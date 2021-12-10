module load_store(

    input logic clk,
    input logic[1:0] state,

    // Instruction Inputs
    input logic lb, // Load Byte
    input logic lbu, // Load Byte Unsigned
    input logic lh, // Load Half-Word
    input logic lhu, // Load Half-Word Unsigned
    input logic lui, // Load Upper Immediate
    input logic lw, // Load Word
    input logic lwl, // Load Word Left
    input logic lwr, // Load Word Right
    input logic sb, // Store Byte
    input logic sh, // Store Half-Word
    input logic sw, // Store Word
    
    input logic[15:0] offset, // Immediate Offset
    input logic [31:0] rs_data, // Base Register (Register containing the address)
    input logic [31:0] rt_data, // Target Register (To store the value in)
    input logic[4:0] rt, //***Needed for loads*** WHY?

    output logic [3:0] reg_byteenable, // Byteenable for the Register file (For selective storing)
    output logic reg_writeenable, // Allow register file to be written to
    //output logic [4:0] //reg_address, // Address of the register to write to
    output logic [31:0] reg_writedata, // Data to write to register file

    output logic [31:0] instruction_out, // Instruction value output
    input logic [31:0] PC_in, // Current PC Value input

    // Avalon Bus Interface

    input logic [31:0] mem_readdata, 
    output logic [3:0] mem_byteenable,
    output logic [31:0] mem_writedata,
    output logic [31:0] mem_address,
    
    input logic waitrequest,
    output logic mem_writeenable,
    output logic mem_readenable

);

    logic [31:0] actual_address;
    logic [31:0] offset_sign_extended;
    reg [31:0] IR;

    initial begin

        // Init Output Variables
        
       reg_byteenable = 4'b1111;
       reg_writeenable = 0;
       //reg_address = 0;
       reg_writedata = 0;
       mem_byteenable = 0;
       mem_writedata = 0;
       mem_writeenable = 0;
       mem_readenable = 0;

    end

    assign instruction_out = IR; // Will only be read during EXEC1

    assign offset_sign_extended = (offset[15] == 1) ? {16'hffff, offset} : {16'h0000, offset};

    assign actual_address = rs_data + offset_sign_extended;
    assign mem_address = (state == 2'b00) ? PC_in : {actual_address[31:2], 2'b00};

    always @ (*) begin
        
        case (state)
            2'b00: begin // FETCH
                
                // RESET VARS

                mem_byteenable = 4'b1111;
                mem_writeenable = 0;
                reg_writeenable = 0;
                reg_byteenable = 4'b1111;

                mem_readenable = 1;

            end

            2'b01: begin // EXEC1

                IR = mem_readdata;

                // RESET VARS

                
                reg_writeenable = 0;
                reg_byteenable = 4'b1111;
                

                if (lw == 1) begin //EXEC1 Load Word
                    mem_byteenable = 4'b1111;
                    mem_readenable = 1;
                    mem_writeenable = 0;
                end
                else if (lb == 1) begin //EXEC1 Load Byte
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b1000 : ( (actual_address[1:0] == 2'b01) ? 4'b0100 : ( (actual_address[1:0] == 2'b10) ? 4'b0010 : 4'b0001 ) );
                    mem_readenable = 1;
                    mem_writeenable = 0;
                end
                else if (lbu == 1) begin //EXEC1 Load Byte Unsigned
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b1000 : (actual_address[1:0] == 2'b01) ? 4'b0100 : (actual_address[1:0] == 2'b10) ? 4'b0010 : 4'b0001;
                    mem_readenable = 1;
                    mem_writeenable = 0;
                end
                else if (lh == 1) begin //EXEC1 Load Halfword
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b1100 : 4'b0011;
                    mem_readenable = 1;
                    mem_writeenable = 0;
                end
                else if (lhu == 1) begin //EXEC1 Load Halfword Unsigned
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b1100 : 4'b0011;
                    mem_readenable = 1;
                    mem_writeenable = 0;
                end
                else if (lwl == 1) begin //EXEC1 Load Word Left
                    mem_readenable = 1;
                    mem_writeenable = 0;
                    case(actual_address[1:0])
                        2'b00: mem_byteenable = 4'b1111;
                        2'b01: mem_byteenable = 4'b0111;
                        2'b10: mem_byteenable = 4'b0011;
                        2'b11: mem_byteenable = 4'b0001;
                    endcase
                end
                else if (lwr == 1) begin //EXEC1 Load Word Right
                    mem_readenable = 1;
                    mem_writeenable = 0;
                    case(actual_address[1:0])
                        2'b00: mem_byteenable = 4'b1000;
                        2'b01: mem_byteenable = 4'b1100;
                        2'b10: mem_byteenable = 4'b1110;
                        2'b11: mem_byteenable = 4'b1111;
                    endcase 
                end
                else if (sw == 1) begin //EXEC1 Store Word
                    mem_writeenable = 1;
                    mem_readenable = 0;
                    mem_writedata = rt_data;
                    mem_byteenable = 4'b1111;
                end
                else if (sb == 1) begin //EXEC1 Store Byte
                    mem_writeenable = 1;
                    mem_readenable = 0;
                    case (actual_address[1:0])
                        2'b00: begin 
                        mem_writedata = {rt_data[7:0], 24'h000000};
                        mem_byteenable = 4'b1000;
                        end
                        2'b01: begin 
                        mem_writedata = {8'h00, rt_data[7:0], 16'h0000};
                        mem_byteenable = 4'b0100;
                        end
                        2'b10: begin 
                        mem_writedata = {16'h0000, rt_data[7:0], 8'h00};
                        mem_byteenable = 4'b0010;
                        end
                        2'b11: begin 
                        mem_writedata = {24'h000000, rt_data[7:0]};
                        mem_byteenable = 4'b0001;
                        end
                    endcase
                end
                else if (sh == 1) begin //EXEC1 Store Halfword
                    mem_writeenable = 1;
                    mem_readenable = 0; 
                    mem_writedata = (actual_address[1] == 1) ? {16'h0000, rt_data[15:0]} : {rt_data[15:0], 16'h0000};
                    mem_byteenable = (actual_address[1] == 1) ? 4'b0011 : 4'b1100;
                end
            end

            2'b10: 
                begin //EXEC2

                    // RESET VARS

                    mem_byteenable = 4'b1111;
                    mem_writeenable = 0;
                    reg_writeenable = 0;
                    mem_readenable = 0;
                    reg_byteenable = 4'b1111;

                    if (lw == 1) begin //EXEC2 Load Word
                        reg_writeenable = 1;
                        //reg_address = rt;
                        reg_byteenable = 4'b1111;
                        reg_writedata = mem_readdata;
                    end
                    else if (lb == 1) begin //EXEC2 Load Byte
                        reg_writeenable = 1;
                        //reg_address = rt;
                        reg_byteenable = 4'b1111;
                        //Sign extended value of the required byte from mem_readdata
                        case (actual_address[1:0])
                            2'b00: begin
                                if (mem_readdata[31] == 1) begin
                                    reg_writedata = {24'hffffff, mem_readdata[31:24]};
                                end
                                else begin
                                    reg_writedata = {24'h000000, mem_readdata[31:24]};
                                end
                            end
                            2'b01: begin
                                if (mem_readdata[23] == 1) begin
                                    reg_writedata = {24'hffffff, mem_readdata[23:16]};
                                end
                                else begin
                                    reg_writedata = {24'h000000, mem_readdata[23:16]};
                                end
                            end
                            2'b10: begin
                                if (mem_readdata[15] == 1) begin
                                    reg_writedata = {24'hffffff, mem_readdata[15:8]};
                                end
                                else begin
                                    reg_writedata = {24'h000000, mem_readdata[15:8]};
                                end
                                
                            end
                            2'b11: begin
                                if (mem_readdata[7] == 1) begin
                                    reg_writedata = {24'hffffff, mem_readdata[7:0]};
                                end
                                else begin
                                    reg_writedata = {24'h000000, mem_readdata[7:0]};
                                end
                            end
                        endcase
                    end
                    else if (lbu == 1) begin //EXEC2 Load Byte Unsigned
                        reg_writeenable = 1;
                        //reg_address = rt;
                        reg_byteenable = 4'b1111;
                        //Zero extended value of the required byte from mem_readdata
                        case (actual_address[1:0])
                            2'b00: reg_writedata = {24'h000000, mem_readdata[31:24]};
                            2'b01: reg_writedata = {24'h000000, mem_readdata[23:16]};
                            2'b10: reg_writedata = {24'h000000, mem_readdata[15:8]};
                            2'b11: reg_writedata = {24'h000000, mem_readdata[7:0]};
                        endcase
                    end
                    else if (lh == 1) begin //EXEC2 Load Halfword 
                        reg_writeenable = 1;
                        //reg_address = rt;
                        reg_byteenable = 4'b1111;
                        //Sign extended value of the required halfword from mem_readdata
                        case (actual_address[1])
                            0: begin
                                if (mem_readdata[31] == 1) begin
                                    reg_writedata = {16'hffff, mem_readdata[31:16]};
                                end
                                else begin
                                    reg_writedata = {16'h0000, mem_readdata[31:16]};
                                end
                            end
                            1: begin
                                if (mem_readdata[15] == 1) begin
                                    reg_writedata = {16'hffff, mem_readdata[15:0]};
                                end
                                else begin
                                    reg_writedata = {16'h0000, mem_readdata[15:0]};
                                end
                            end
                        endcase
                    end
                    else if (lhu == 1) begin //EXEC2 Load Halfword Unsigned
                        reg_writeenable = 1;
                        //reg_address = rt;
                        reg_byteenable = 4'b1111;
                        //Zero extended value of the required byte from mem_readdata
                        case (actual_address[1])
                            0: reg_writedata = {16'h0000, mem_readdata[31:16]};
                            1: reg_writedata = {16'h0000, mem_readdata[15:0]};
                        endcase
                        
                    end
                    else if (lui == 1) begin //EXEC2 Load Upper Immediate
                        reg_writeenable = 1;
                        reg_writedata = {offset[15:0], 16'h0000};
                    end
                    else if (lwl == 1) begin
                        reg_writeenable = 1;
                        case(actual_address[1:0])
                            2'b00: reg_writedata = mem_readdata;
                            2'b01: reg_writedata = {mem_readdata[23:0], rt_data[7:0]};
                            2'b10: reg_writedata = {mem_readdata[15:0], rt_data[15:0]};
                            2'b11: reg_writedata = {mem_readdata[7:0], rt_data[23:0]};
                        endcase
                    end
                    else if (lwr == 1) begin
                        reg_writeenable = 1;
                        case(actual_address[1:0])
                            2'b00: reg_writedata = {rt_data[31:8], mem_readdata[31:24]};
                            2'b01: reg_writedata = {rt_data[31:16], mem_readdata[31:16]};
                            2'b10: reg_writedata = {rt_data[31:24], mem_readdata[31:8]};
                            2'b11: reg_writedata = mem_readdata;
                        endcase
                    end
                end
        
        endcase
    end

endmodule