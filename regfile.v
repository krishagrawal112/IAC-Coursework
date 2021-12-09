/* INSTRUCTION FOR ALU AND LOADSTORE BLOCK PEOPLE:
ALU: -----------------------------------------------
When you want to write you need to input write_data_ALU, and make write_enable_ALU high
LOADSTORE: -----------------------------------------------------------------------------
When you want to write something you need to input write_data_ld, byteeenable_ld and write_enable_ld
*/
module regfile (
    input logic clk,
    input logic rst,
    input logic[4:0] addr_rs,
    input logic[4:0] addr_rt,
    input logic write_enable_ld,
    input logic write_enable_ALU,
    input logic write_enable_PC,
    input logic link,
    input logic[4:0] addr_rd,
    input logic[31:0] write_data_ld,
    input logic[31:0] write_data_ALU,
    input logic[31:0] write_data_PC,
    output logic[31:0] read_data_1,
    output logic[31:0] read_data_2,
    input logic[3:0] byteenable_ld,
    input logic rType,
    output logic[31:0] v0,
    input logic[1:0] state
);
logic[3:0] byteenable;
logic[31:0] write_data;
logic[4:0] write_addr;
logic write_enable;


reg[31:0] register[31:0];
integer i;

initial begin
<<<<<<< Updated upstream
    for(i = 0; i<32; i++) begin
        register[i]= 0;
    end
end

assign v0 = register[2];

=======
    for(i = 0; i < 32; i++) begin 
        register[i] = 0;
    end
end

assign v0 = register[2];
>>>>>>> Stashed changes
always_comb begin
    //Read data:
    read_data_1 = addr_rs == 0 ? 0 : register[addr_rs];
    read_data_2 = addr_rt == 0 ? 0 : register[addr_rt];

    //Determining where to write, and what to write
    if(write_enable_ALU == 1 && state == 2)begin
        write_enable = 1;
        write_addr = rType ? addr_rd : addr_rt;
        write_data = write_data_ALU;
        byteenable = 4'b1111;
    end
    else if(write_enable_ld == 1)begin
        write_enable = 1;
        write_addr = addr_rt;
        write_data = write_data_ld;
        byteenable = byteenable_ld;
    end
    else if(write_enable_PC == 1)begin
        write_enable = 1;
        write_data = write_data_PC;
        write_addr = link ? 31 : addr_rd;
        byteenable = 4'b1111;
    end
    else write_enable = 0;
    
end
always_ff @(posedge clk) begin
    //Bit writes handled
<<<<<<< Updated upstream
=======
    //v0 <= register[2];
>>>>>>> Stashed changes
    if(write_addr != 0 && write_enable == 1) begin
        case(byteenable) 
            4'b0001: register[write_addr][7:0] <= write_data[7:0];
            4'b0010: register[write_addr][15:8] <= write_data[15:8];
            4'b0100: register[write_addr][23:16] <= write_data[23:16];
            4'b1000: register[write_addr][31:24] <= write_data[31:24];
            4'b1100: register[write_addr][31:16] <= write_data[31:16];
            4'b1110: register[write_addr][31:8] <= write_data[31:8];
            4'b0011: register[write_addr][15:0] <= write_data[15:0];
            4'b0111: register[write_addr][23:0] <= write_data[23:0];
            4'b1111: register[write_addr] <= write_data;
            default: register[write_addr] <= 32'hxxxxxxxx;
        endcase
            
        
    end
    if(rst == 1)
    begin
        for(i = 0; i < 32; i++) begin
            register[i] <= 0;
        end
    end
end

endmodule