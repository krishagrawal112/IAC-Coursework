module ram(
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data,
    input logic write_enable,
    inout logic read_enable,
    input clk
);

reg[7:0] memory [4294967295:0];
integer i;
initial begin
    for(i = 0; i < 4294967296; i++) begin
        memory[i] = 0;
    end
    $readmemb("test.txt", memory);
end

always_ff @(posedge clk)begin
    if(write_enable) begin
        memory[address ] <= write_data[31:24];
        memory[address + 1] <= write_data[23:16];
        memory[address + 2] <= write_data[15:8];
        memory[address + 3] <= write_data[7:0];
    end
    else if(read_enable)begin
        read_data = {memory[address], memory[address + 1], memory[address + 2], memory[address+3]};
    end
end
endmodule
