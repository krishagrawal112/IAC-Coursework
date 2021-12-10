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

//RAM
logic[31:0] shifted_address;
assign shifted_address = address - 32'hBFC00000;
reg[31:0] memory [1000:0];

initial begin
    $dumpfile("result.vcd");
    $dumpvars(0, general_tb);

    $readmemb("ram.txt", memory);

    while(active) begin

       clk = !clk; #10;

        if (clk) begin
            if(write) memory[shifted_address/4] <= writedata;
            readdata <= address == 0 ? 0 : memory[shifted_address/4];
        end
        
    end
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

endmodule