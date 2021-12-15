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
        #10; reset = 0; clk = !clk;
    end

    $fatal(1);    
end

initial begin
    
    while (active == 1) begin
        
        @ (posedge clk) begin
            if (write) begin
                if (byteenable[3]==1) begin
                    memory[shifted_address/4][31:24] <= writedata[31:24];
                end
                if (byteenable[2]==1) begin
                    memory[shifted_address/4][23:16] <= writedata[23:16];
                end
                if (byteenable[1]==1) begin
                    memory[shifted_address/4][15:8] <= writedata[15:8];
                end
                if (byteenable[0]==1) begin
                    memory[shifted_address/4][7:0] <= writedata[7:0];
                end
            end

            if (byteenable[3]==1) begin
                readdata[31:24] <= (address == 0) ? 0 : memory[shifted_address/4][31:24];
            end
            if (byteenable[2]==1) begin
                readdata[23:16] <= (address == 0) ? 0 : memory[shifted_address/4][23:16];
            end
            if (byteenable[1]==1) begin
                readdata[15:8] <= (address == 0) ? 0 : memory[shifted_address/4][15:8];
            end
            if (byteenable[0]==1) begin
                readdata[7:0] <= (address == 0) ? 0 : memory[shifted_address/4][7:0];
            end
        end
    end

    // Test Cases 

<<<<<<< Updated upstream
    if (register_v0 == 32'h00002222)begin
        $finish;
    end
    else begin
        $fatal(1);
=======
    if (resgister_v0==32'h00002222)begin
        $finish;
    end
    else begin
        $fatal(2);
>>>>>>> Stashed changes
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