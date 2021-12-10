module RAM(
    input logic[31:0] address,
    input logic clk,
    output logic[31:0] read_data,
    input logic[31:0] write_data,
    input logic write_enable
);
logic[31:0] shifted_address = address - 32'hBFC00000;
reg[31:0] memory [1000:0];
integer i;
initial begin
    

    $readmemb("ram.txt", memory);
    

end

always_ff @(posedge clk)begin
    if(write_enable) memory[shifted_address/4] <= write_data;
    read_data <= address == 0 ? 0 : memory[shifted_address/4];
end

endmodule