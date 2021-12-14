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
reg[31:0] memory [1000:0];

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

    if (memory[64] != 32'h11112222)begin
        $display("memory[64] != 32'h11112222");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[65] != 32'h22224444) begin
        $display("memory[65] != 32'h22224444");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[66] != 32'h11114444) begin
        $display("memory[66] != 32'h11114444");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[67] != 32'h11114445) begin
        $display("memory[67] != 32'h11114445");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[68] != 32'h00004444) begin
        $display("memory[68] != 32'h00004444");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[69] != 32'h0000BBBB) begin
        $display("memory[69] != 32'h0000BBBB");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[70] != 32'h11110001) begin
        $display("memory[70] != 32'h11110001");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[71] != 32'h00000004) begin
        $display("memory[71] != 32'h00000004");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[72] != 32'h80000000) begin
        $display("memory[72] != 32'h80000000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[73] != 32'hE0000000) begin
        $display("memory[73] != 32'hE0000000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[74] != 32'hF0000000) begin
        $display("memory[74] != 32'hF0000000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[75] != 32'h0f000000) begin
        $display("memory[75] != 32'h0f000000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[76] != 32'h0e800000) begin
        $display("memory[76] != 32'h0e800000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[77] != 32'h0f000000) begin
        $display("memory[77] != 32'h0f000000");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[78] != 1) begin
        $display("memory[78] != 1");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[79] != 0) begin
        $display("memory[79] != 0");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[80] != 1) begin
        $display("memory[80] != 1");
        $fatal(1, "ALU Test Failed.");
    end
    else if (memory[81] != 1) begin
        $display("memory[81] != 1");
        $fatal(1, "ALU Test Failed.");
    end
    else begin
        $display("ALU Test Passed");
        $finish;
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