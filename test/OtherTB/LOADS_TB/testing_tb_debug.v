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

    if (memory[65] == 32'h11118888)begin
        $display ("memory[65] == 32'h11118888");
        
    end
    if (memory[66] == 32'h00001111) begin
        $display ("memory[66] == 32'h00001111");
        
    end 
    if (memory[67] == 32'hffff8888) begin
        $display ("memory[67] == 32'hffff8888");
        
    end
    if (memory[68] == 32'h00001111) begin
        $display ("memory[68] == 32'h00001111");
        
    end
    if (memory[69] == 32'h00008888) begin
        $display ("memory[69] == 32'h00008888");
        
    end
    if (memory[70] == 32'h00000011) begin
        $display ("memory[70] == 32'h00000011");
        
    end
    if (memory[71] == 32'hffffff88) begin
        $display ("memory[71] == 32'hffffff88");
        
    end
    if (memory[72] == 32'h00000011) begin
        $display ("memory[72] == 32'h00000011");
        
    end
    if (memory[73] == 32'hffffff88) begin 
        $display ("memory[73] == 32'hffffff88");
        
    end
    if (memory[74] == 32'h00000011) begin
        $display ("memory[74] == 32'h00000011");
        
    end
    if (memory[75] == 32'h00000011) begin
        $display ("memory[75] == 32'h00000011");
        
    end
    if (memory[76] == 32'h00000088) begin
        $display ("memory[76] == 32'h00000088");
        
    end
    if (memory[77] == 32'h00000088) begin
        $display ("memory[77] == 32'h00000088");
        
    end
    if (memory[78] == 32'h88EE0000) begin
        $display ("memory[78] == 32'h88EE0000");
        
    end
    if (memory[79] == 32'h88880000) begin
        $display ("memory[79] == 32'h88880000");
        
    end
    if (memory[80] == 32'h118888EE) begin
        $display ("memory[80] == 32'h118888EE");
        
    end
    if (memory[81] == 32'h11118888) begin
        $display ("memory[81] == 32'h11118888");
        
    end
    if (memory[82] == 32'heeeeee11) begin
        $display ("memory[82] == 32'heeeeee11");
        
    end
    if (memory[83] == 32'heeee1111) begin
        $display ("memory[83] == 32'heeee1111");
        
    end
    if (memory[84] == 32'hee111188) begin
        $display ("memory[84] == 32'hee111188");
        
    end
    if (memory[85] == 32'h11118888) begin
        $display ("memory[85] == 32'h11118888");
        
    end
    $finish;
    

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