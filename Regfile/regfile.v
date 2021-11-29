module regfile (
    input logic clk,
    input logic rst,
    input logic[4:0] read_addr_1,
    input logic[4:0] read_addr_2,
    input logic write_enable,
    input logic[4:0] write_addr,
    input logic[31:0] write_data,
    output logic[31:0] read_data_1,
    output logic[31:0] read_data_2,
    input logic[3:0] byteenable
);

reg[31:0] register[31:0];
integer i;
always_comb begin
    read_data_1 = read_addr_1 == 0 ? 0 : register[read_addr_1];
    read_data_2 = read_addr_2 == 0 ? 0 : register[read_addr_2];
end
always_ff @(posedge clk) begin
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