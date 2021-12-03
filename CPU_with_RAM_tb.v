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