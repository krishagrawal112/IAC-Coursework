module regfile_tb();

logic clk;
logic rst;
logic[4:0] read_addr_1;
logic[4:0] read_addr_2;
logic write_enable;
logic[4:0] write_addr;
logic[31:0] write_data;
logic[31:0] read_data_1;
logic[31:0] read_data_2;
logic[3:0] byteenable;

initial begin 
    clk = 0;
    read_addr_1 = 0;
    read_addr_2 = 0;
    write_enable = 1;
    write_addr = 12;
    write_data = 32'hABCD1234;
    byteenable = 4'b1111;
    #1
    clk = 1;
    #1
    clk = 0;
    
    read_addr_1 = 12;
    #1
    $display("Reading address %d : %h", read_addr_1, read_data_1);
    $display("Reading address %d : %h", read_addr_2, read_data_2);
    assert(read_data_1 == 32'hABCD1234);
    write_data = 32'h12121212;
    byteenable = 4'b1000;
    #1
    clk = 1;
    #1
    clk = 0;
    $display("Reading address %d : %h", read_addr_1, read_data_1);
    $display("Reading address %d : %h", read_addr_2, read_data_2);
    rst = 1;
    clk = 1;
    #1
    $display("Reading address %d : %h", read_addr_1, read_data_1);
    $display("Reading address %d : %h", read_addr_2, read_data_2);
end
regfile r(
    .clk(clk),
    .rst(rst),
    .read_addr_1(read_addr_1),
    .read_addr_2(read_addr_2),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2),
    .write_enable(write_enable),
    .write_data(write_data),
    .write_addr(write_addr),
    .byteenable(byteenable)
);
endmodule