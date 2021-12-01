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
    assign reg_writedata = mem_readdata; // Same as above /\

    assign mem_address = (state == 2'b00) ? PC_in : {rs_data[31:2], 2'b00} + (offset_sign_extended<<2);

    logic [31:0] offset_sign_extended

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

                if (lw == 1) begin
                
                end
                else if (lb == 1) begin
                
                end
                else if (lbu == 1) begin
                
                end
                else if (lh == 1) begin
                
                end
                else if (lhu == 1) begin
                
                end
                else if (lui == 1) begin
                
                end
                else if (lwl == 1) begin
                
                end
                else if (lwr == 1) begin
                
                end
                else if (sw == 1) begin
                    //mem_address = rs_data + (offset_sign_extended*4);  
                    mem_writeenable = 1;
                    mem_writedata = rt;
                    mem_byteenable = 4'b1111;
                end
                else if (sb == 1) begin
                    //mem_address = {rs_data[31:2], 2'b00} + (offset_sign_extended<<2)
                    mem_writeenable = 1
                    mem_writedata = rt[7:0]
                    mem_byteenable = (rs_data[1:0] == 2'b00) ? 4'b0001 : (rs_data[1:0] == 2'b01) ? (rs_data[1:0] == 2'b00) ? 4'b0001 :(rs_data[1:0] == 2'b00) ? 4'b0001 :
                end
                else if (sh == 1) begin
                
                end
            end

            2'b10: begin // EXEC2

                instruction_out = 0

                if (lw == 1) begin
                
                end
                else if (lb == 1) begin
                
                end
                else if (lbu == 1) begin
                
                end
                else if (lh == 1) begin
                
                end
                else if (lhu == 1) begin
                
                end
                else if (lui == 1) begin
                
                end
                else if (lwl == 1) begin
                
                end
                else if (lwr == 1) begin
                
                end
                else if (sw == 1) begin
                
                end
                else if (sb == 1) begin
                
                end
                else if (sh == 1) begin
                
                end
            end

            default: 
        
        endcase
    end

    always_ff @ (posedge clk) begin
        
    end


endmodule