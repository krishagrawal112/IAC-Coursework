module testing_tb ();

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
reg[31:0] memory [0:1000];

initial begin
    $dumpfile("result.vcd");
    $dumpvars(0, testing_tb);
    $readmemb("ram.txt", memory);

    clk = 0;

    reset = 1;

    repeat(1000) begin
        #10; reset = 0;; clk = !clk;
    end

    $fatal(1, "Timeout error");    
end

initial begin
    
    while (active == 1) begin
        
        @ (posedge clk) begin
            if (write) begin
                memory[shifted_address/4] <= writedata;
            end

            readdata <= (address == 0) ? 0 : memory[shifted_address/4];
        end
    end

    // Test Cases 

    if ((memory[1]==32'hffffffff) && (memory[2]==32'hff000000) && (memory[3]==32'h00ff0000) && (memory[4]==32'h0000ff00) && (memory[5]==32'h000000ff) && (memory[6]==32'hffff0000) && (memory[7]==32'h0000ffff)) begin
        $display("Test Passed");
        $finish;
    end
    else begin
        $fatal(1, "Test Failed.");
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

endmodule