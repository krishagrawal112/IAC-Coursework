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
    input logic[4:0] rs;
    input logic[4:0] rt;
    input logic[15:0] offset;
    input logic [31:0] rs_data,
    input logic [31:0] rt_data,

    input logic [31:0] mem_readdata,
    output logic reg_writeenable,
    output logic [3:0] reg_byteenable,
    output logic [4:0] reg_addr,

    
    output logic mem_writeenable,
    output logic [3:0] mem_byteenable
    output logic [31:0] mem_writedata,
    output logic [31:0] mem_address,
    

    input logic waitrequest,
    
    //output logic [31:0] address,
    //output logic write,
    //output logic read,
    //output logic [31:0] mem_writedata,
    //output logic [3:0] mem_byteenable
    
    //Avalon bus
    output logic[31:0] address,
    output logic write,
    output logic read,
    input logic waitrequest,
    output logic[31:0] writedata,
    output logic[3:0] byteenable,
    input logic[31:0] readdata

);

    always_comb begin
        if (lw == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lh == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lhu == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lb == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lbu == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lui == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lwl == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (lwr == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (sw == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (sh == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end
        if (sb == 1) begin
            case (state)
                2'b00: begin
                    
                end
                2'b01: begin
                    
                end
                2'b10: begin
                    
                end
                default: 
            endcase
        end

    end

    always_ff @ (posedge clk) begin
        
    end


endmodule