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

    if ((memory[65] == 32'h11118888) && (memory[66] == 32'h00001111) && (memory[67] == 32'hffff8888) && (memory[68] == 32'h00001111) && (memory[69] == 32'h00008888) && (memory[70] == 32'h00000011) && && (memory[71] == 32'hffffff88) && (memory[72] == 32'h00000011) && (memory[73] == 32'hffffff88) && (memory[74] == 32'h00000011) && (memory[75] == 32'h00000011) && (memory[76] == 32'h00000088) && (memory[77] == 32'h00000088) && (memory[78] == 32'h88EE0000) && (memory[79] == 32'h88880000) && (memory[80] == 32'h118888EE) && (memory[81] == 32'h11118888) && (memory[82] == 32'heeeeee11) && (memory[83] == 32'heeee1111) && (memory[84] == 32'hee111188) && (memory[85] == 32'h11118888))begin
        $display("Loads Test Passed");
        $finish;
    end
    else begin
        $fatal(1, "Loads Test Failed.");
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