module RAM(
    input logic[31:0] address,
    input logic clk,
    output logic[31:0] read_data,
    input logic[31:0] write_data,
    input logic write_enable
);

reg[31:0] memory [536870911:0]
integer i;
initial begin
    for(i = 0; i < 536870912; i++) memory[i] = 0;
/*
    $readmemh("test1.txt", memory);
    for (i = 0; i < 30; i++) begin
        $display("%h: %h", i, memory[i]);
    end

*/
end

always_ff @(posedge clk)begin
    if(write_enable) memory[address/4] <= write_data;
    read_data <= memory[address/4];
end

endmodule