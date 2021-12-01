module load_store(

    input logic clk,
    input logic[1:0] state,

    // Instruction Inputs
    input logic lb,
    input logic lbu,
    input logic lh,
    input logic lhu,
    input logic lui,
    input logic lw,
    input logic lwl,
    input logic lwr,
    input logic sb,
    input logic sh,
    input logic sw,
    
    input logic[15:0] offset;
    input logic [31:0] rs_data,
    input logic [31:0] rt_data,
    input logic[4:0] rt; //***Needed for loads***

    output logic [3:0] reg_byteenable,
    output logic reg_writeenable,
    output logic [4:0] reg_address,
    output logic [31:0] reg_writedata,

    output logic [31:0] instruction_out,
    input logic [31:0] PC_in,

    // Avalon Bus Interface

    input logic [31:0] mem_readdata,
    output logic [3:0] mem_byteenable
    output logic [31:0] mem_writedata,
    output logic [31:0] mem_address,
    
    input logic waitrequest,
    output logic mem_writeenable,
    output logic mem_readenable,

);

    logic[31:0] word_address;
    logic[31:0] actual_address
    initial begin
        
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

    end

    assign instruction_out = mem_readdata; // Both output the same stuff each time, this just makes it easier to get the outputs
    //***Can't assign reg_writedata to mem_readdata directly because lb,lh,lui,lwl,lwr need more work***
    //assign reg_writedata = mem_readdata; // Same as above /\

    //***Some changes, I don't thinh immediate is multiplied by 4***
    //assign mem_address = (state == 2'b00) ? PC_in : {rs_data[31:2], 2'b00} + (offset_sign_extended<<2);
    assign actual_address = rs_data + offset_sign_extended; //***Can't use offset_sign_extended before assignment***
    assign word_address = (state == 2'b00) ? PC_in : {actual_address[31:2], 00};

    logic [31:0] offset_sign_extended;

    always_comb begin
        if (offset[15] == 1) begin
            offset_sign_extended = {16'hffff, offset}
        end
        else begin
            offset_sign_extended = {16'h0000, offset}
        end
        
        case (state)
            2'b00: begin // FETCH
                
                reg_byteenable = 4'b1111;

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
                else if (lui == 1) begin //EXEC1 Load Upper Immediate
                    reg_writeenable = 1;
                    reg_writedata = offset << 16;
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
                    //mem_address = rs_data + (offset_sign_extended*4);  
                    mem_writeenable = 1;
                    mem_writedata = rt;
                    mem_byteenable = 4'b1111;
                end
                else if (sb == 1) begin //EXEC1 Store Byte
                    //mem_address = {rs_data[31:2], 2'b00} + (offset_sign_extended<<2)
                    mem_writeenable = 1;
                    mem_writedata = {24'h000000, rt[7:0]};
                    mem_byteenable = (actual_address[1:0] == 2'b00) ? 4'b0001 : (actual_address[1:0] == 2'b01) ? : 4'b0010 : (actual_address[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
                end
                else if (sh == 1) begin //EXEC1 Stgore Halfword
                    mem_writeenable = 1; 
                    mem_writedata = {16'h0000, rt[15:0]};
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
                //else if (lui == 1) begin
                //
                //end
                else if (lwl == 1) begin
                    case(actual_address[1:0]):
                    2'b00: reg_writedata = mem_readdata;
                    2'b01: reg_writedata = {mem_readdata[23:0], rt[7:0]};
                    2'b10: reg_writedata = {mem_readdata[15:0], rt[15:0]};
                    2'b11: reg_writedata = {mem_readdata[7:0], rt[23:0]};
                end
                else if (lwr == 1) begin
                    2'b00: reg_writedata = mem_readdata;
                    2'b01: reg_writedata = {rt[31:8], mem_readdata[31:24]};
                    2'b10: reg_writedata = {rt[31:16], mem_readdata[31:16]};
                    2'b11: reg_writedata = {rt[31:24], mem_readdata[31:8]};
                end
                //else if (sw == 1) begin
                //
                //end
                //else if (sb == 1) begin
                //
                //end
                //else if (sh == 1) begin
                //
                //end
            end

            default: 
        
        endcase
    end

    always_ff @ (posedge clk) begin
        
    end


endmodule