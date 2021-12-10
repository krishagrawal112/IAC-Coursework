module general_tb ();

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
    $dumpfile("result.vcd");
    $dumpvars(0, general_tb);

    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //1st instruction
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //2nd instruction
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //3rd instruction
    assert(register_v0 == 32'h80000008);
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //4th instruction
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //5th instruction
    assert(register_v0 == 32'hffffffff);
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //6th instruction
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //7th instruction
    assert(register_v0 == 1);
    
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    //8th instruction
    assert(register_v0 == 3);
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    clk = 1;
    #1
    assert(register_v0 == 32'hBFC00020);
    //9th instruction
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