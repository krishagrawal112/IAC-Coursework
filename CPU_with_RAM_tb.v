module CPU_with_RAM_tb ();

logic clk,
logic reset,
logic active;
logic[31:0] register_v0;

logic waitrequest;
logic [31:0] readdata;
logic [31:0] address;
logic write;
logic read;
logic [31:0] writedata;
logic [3:0] byteenable;


initial begin
    clk = 0;
    repeat(1000) begin
        #1
        clk = !clk;
    end
end

mips_cpu_bus m1(
    .clk(clk),
    .reset(reset),
    .active(active),
    .register_v0(register_v0),
    .waitrequest(waitrequest),
    .readdata(readdata),
    .address(address),
    .write(write),
    .read(read),
    .writedata(writedata),
    .byteenable(byteenable)
);

RAM r1(
    .clk(clk),
    .address(address),
    .read_data(readdata),
    .wirte_data(writedata),
    .write_enable(write)

);
endmodule