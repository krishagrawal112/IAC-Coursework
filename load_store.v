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
    input logic[4:0] rt; //***Needed for loads*** WHY?

    output logic [3:0] reg_byteenable, // Byteenable for the Register file (For selective storing)
    output logic reg_writeenable, // Allow register file to be written to
    output logic [4:0] reg_address, // Address of the register to write to
    output logic [31:0] reg_writedata, // Data to write to register file

    output logic [31:0] instruction_out, // Instruction value output
    input logic [31:0] PC_in, // Current PC Value input

    // Avalon Bus Interface

    input logic [31:0] mem_readdata, 
    output logic [3:0] mem_byteenable
    output logic [31:0] mem_writedata,
    output logic [31:0] mem_address,
    
    input logic waitrequest,
    output logic mem_writeenable,
    output logic mem_readenable,

);

    logic [31:0] actual_address;
    logic [31:0] offset_sign_extended;
    logic [31:0] outputData;

    initial begin

        // Init Output Variables
        
       reg_byteenable = 4'b1111;
       reg_writeenable = 0;
       reg_address = 0;
       reg_writedata = 0;
       instruction_out = 0;
       mem_byteenable = 0;
       mem_writedata = 0;
       mem_address = 0;
       mem_writeenable = 0;
       mem_readenable = 1;

        // Init Internal Variables
        actual_address = 0;
        offset_sign_extended = 0;

    end

    assign instruction_out = mem_readdata; // Will only be read during EXEC1

    assign actual_address = rs_data + offset_sign_extended; //***Can't use offset_sign_extended before assignment***
    assign mem_address = (state == 2'b00) ? PC_in : {actual_address[31:2], 00};

    always_comb begin

        // Can this not be put into an assign statement? \/

        if (offset[15] == 1) begin
            offset_sign_extended = {16'hffff, offset}
        end
        else begin
            offset_sign_extended = {16'h0000, offset}
        end
        
        case (state)
            2'b00: begin // FETCH
                
                mem_byteenable = 4'b1111;

            end

            2'b01: begin // EXEC1

                if (lw == 1) begin //EXEC1 Load Word
                    mem_byteenable = 4'b1111;
                end
                else if (lb == 1) begin //EXEC1 Load Byte
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0001 : (actual_address[1:0] == 2'b01) ? : 4'b0010 : (actual_address[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
                end
                else if (lbu == 1) begin //EXEC1 Load Byte Unsigned
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0001 : (actual_address[1:0] == 2'b01) ? : 4'b0010 : (actual_address[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
                end
                else if (lh == 1) begin //EXEC1 Load Halfword
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0011 : 4'b1100;
                end
                else if (lhu == 1) begin //EXEC1 Load Halfword Unsigned
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0011 : 4'b1100;
                end
                else if (lwl == 1) begin //EXEC1 Load Word Left
                    case(actual_address[1:0]):
                    2'b00: mem_byteenable = 4'b1111;
                    2'b01: mem_byteenable = 4'b0111;
                    2'b10: mem_byteenable = 4'b0011;
                    2'b11: mem_byteenable = 4'b0001;
                end
                else if (lwr == 1) begin //EXEC1 Load Word Right
                    case(actual_address[1:0]):
                        2'b00: mem_byteenable = 4'b1000;
                        2'b01: mem_byteenable = 4'b1100;
                        2'b10: mem_byteenable = 4'b1110;
                        2'b11: mem_byteenable = 4'b1111;
                    end
                else if (sw == 1) begin //EXEC1 Store Word
                    mem_writeenable = 1;
                    mem_writedata = rt_data;
                    mem_byteenable = 4'b1111;
                end
                else if (sb == 1) begin //EXEC1 Store Byte
                    mem_writeenable = 1;
                    mem_writedata = {24'h000000, rt_data[7:0]};
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0001 : (actual_address[1:0] == 2'b01) ? : 4'b0010 : (actual_address[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
                end
                else if (sh == 1) begin //EXEC1 Stgore Halfword
                    mem_writeenable = 1; 
                    mem_writedata = {16'h0000, rt_data[15:0]};
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0011 : 4'b1100;
            end

            2'b10: begin //EXEC2

                instruction_out = 0

                if (lw == 1) begin //EXEC2 Load Word
                    reg_writeenable = 1;
                    reg_address = rt;
                    reg_byteenable = 4'b1111;
                    reg_writedata = mem_readdata;
                end
                else if (lb == 1) begin //EXEC2 Load Byte
                    reg_writeenable = 1;
                    reg_address = rt;
                    reg_byteenable = 4'b1111;
                    //Sign extended value of the required byte from mem_readdata
                    case (actual_address[1:0])
                        2'b00: begin
                            if (mem_readdata[7] == 1) begin
                                reg_writedata = {24'hffffff, mem_readdata[7:0]};
                            end
                            else begin
                                reg_writedata = {24'h000000, mem_readdata[7:0]};
                            end
                        end
                        2'b01: begin
                            if (mem_readdata[15] == 1) begin
                                reg_writedata = {24'hffffff, mem_readdata[15:7]};
                            end
                            else begin
                                reg_writedata = {24'h000000, mem_readdata[15:7]};
                            end
                        end
                        2'b10: begin
                            if (mem_readdata[23] == 1) begin
                                reg_writedata = {24'hffffff, mem_readdata[23:16]};
                            end
                            else begin
                                reg_writedata = {24'h000000, mem_readdata[23:16]};
                            end
                            
                        end
                        2'b11: begin
                            if (mem_readdata[31] == 1) begin
                                reg_writedata = {24'hffffff, mem_readdata[31:24]};
                            end
                            else begin
                                reg_writedata = {24'h000000, mem_readdata[31:24]};
                            end
                        end
                    endcase
                end
                else if (lbu == 1) begin //EXEC2 Load Byte Unsigned
                    reg_writeenable = 1;
                    reg_address = rt;
                    reg_byteenable = 4'b1111;
                    //Zero extended value of the required byte from mem_readdata
                    case (actual_address[1:0])
                        2'b00: reg_writedata = {24'h000000, mem_readdata[7:0]};
                        2'b01: reg_writedata = {24'h000000, mem_readdata[15:7]};
                        2'b10: reg_writedata = {24'h000000, mem_readdata[23:16]};
                        2'b11: reg_writedata = {24'h000000, mem_readdata[31:24]};
                    endcase
                end
                else if (lh == 1) begin //EXEC2 Load Halfword 
                    reg_writeenable = 1;
                    reg_address = rt;
                    reg_byteenable = 4'b1111;
                    //Sign extended value of the required halfword from mem_readdata
                    case (actual_address[1:0])
                        2'b00: begin
                            if (mem_readdata[15] == 1) begin
                                reg_writedata = {16'hffffff, mem_readdata[15:0]};
                            end
                            else begin
                                reg_writedata = {16'h000000, mem_readdata[15:0]};
                            end
                        end
                        2'b10: begin
                            if (mem_readdata[31] == 1) begin
                                reg_writedata = {16'hffffff, mem_readdata[31:16]};
                            end
                            else begin
                                reg_writedata = {16'h000000, mem_readdata[31:16]};
                            end
                        end
                    endcase
                end
                else if (lhu == 1) begin //EXEC2 Load Halfword Unsigned
                    reg_writeenable = 1;
                    reg_address = rt;
                    reg_byteenable = 4'b1111;
                    //Zero extended value of the required byte from mem_readdata
                    case (actual_address[1:0])
                        2'b00: reg_writedata = {16'h000000, mem_readdata[15:0]};
                        2'b10: reg_writedata = {16'h000000, mem_readdata[31:15]};
                    endcase
                    
                end
                else if (lui == 1) begin //EXEC2 Load Upper Immediate
                    reg_writeenable = 1;
                    reg_writedata = offset << 16;
                end
                else if (lwl == 1) begin
                    case(actual_address[1:0]):
                    2'b00: reg_writedata = mem_readdata;
                    2'b01: reg_writedata = {mem_readdata[23:0], rt_data[7:0]};
                    2'b10: reg_writedata = {mem_readdata[15:0], rt_data[15:0]};
                    2'b11: reg_writedata = {mem_readdata[7:0], rt_data[23:0]};
                end
                else if (lwr == 1) begin
                    2'b00: reg_writedata = mem_readdata;
                    2'b01: reg_writedata = {rt_data[31:8], mem_readdata[31:24]};
                    2'b10: reg_writedata = {rt_data[31:16], mem_readdata[31:16]};
                    2'b11: reg_writedata = {rt_data[31:24], mem_readdata[31:8]};
                end
            end

            default: 
        
        endcase
    end

    always_ff @ (posedge clk) begin
        
    end


endmodule