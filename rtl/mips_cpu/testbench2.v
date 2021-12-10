module tb2 ();

logic clk;
logic reset;
logic active;
logic[31:0] register_v0;
logic waitrequest;
logic [31:0] readdata;
logic [31:0] address;
logic write;
logic read;
logic [31:0] writedata;
logic [3:0] byteenable;



// FOR AUTO-CLOCKED UNCOMMENT THIS
/*
initial begin
    clk = 0;


    // FOR WAVEFORMS UNCOMMENT THIS:
    //$dumpfile("result.vcd");
    //$dumpvars(0, <insert_module_name_here>);


    repeat(10000) clk = !clk;
    
end
*/

initial begin
    $dumpfile("result2.vcd");
    $dumpvars(0, tb2);

    

end




mips_cpu_bus m1(
    .reset(reset),
    .active(active),
    .register_v0(register_v0),
    .waitrequest(waitrequest),
    .readdata(readdata),
    .address(address),
    .write(write),
    .read(read),
    .writedata(writedata),
    .byteenable(byteenable),
    .clk
);
RAM r1(
    .address(address),
    .write_data(writedata),
    .read_data(readdata),
    .write_enable(write),
    .clk(clk)
);

endmodule




module RAM(
    input logic[31:0] address,
    input logic clk,
    output logic[31:0] read_data,
    input logic[31:0] write_data,
    input logic write_enable
);

reg[31:0] memory [1073741823:0];
integer i;
initial begin
    

    $readmemb("ram.txt", memory);
    

end

always_ff @(posedge clk)begin
    if(write_enable) memory[address/4] <= write_data;
    read_data <= memory[address/4];
end

endmodule