module mult_tb ();

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
    $dumpvars(0, mult_tb);
    clk = 0;
    #1
    reset = 1;
    #1
    clk = 1;
    #1
    clk = 0;
    #1
    reset = 0;
    #1
    repeat(100)
    begin
        clk = !clk;
        #1;
    end
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
logic[31:0] shifted_address ;
assign shifted_address = address - 32'hBFC00000;
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