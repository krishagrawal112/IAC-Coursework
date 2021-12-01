module load_store(

    input logic clk,
    input logic[1:0] state,
    input logic lb,
    input logic lbu,
    input logic lh,
    input logic lhu,
    input logic lui,
    input logic lw,
    input logic lwl,
    input logic lwr,
    input logic sb,
    input logic sh,
    input logic sw,
    input logic[4:0] rs;
    input logic[4:0] rt;
    input logic[15:0] offset;
    input logic [31:0] rs_data,

    
    input logic [31:0] mem_readdata,
    output logic reg_writeenable,
    output logic [3:0] reg_byteenable,
    output logic [4:0] reg_addr,

    input logic [31:0] rt_data,
    output logic mem_writeenable,
    output logic [3:0] mem_byteenable
    output logic [31:0] mem_writedata,
    output logic [31:0] mem_address,
    

    input logic waitrequest,
    
    //output logic [31:0] address,
    //output logic write,
    //output logic read,
    //output logic [31:0] mem_writedata,
    //output logic [3:0] mem_byteenable

);

    always_comb begin
        if (lw == 1) begin
            if (state == 2'b01)begin
                
            end
            if (state == 2'b
            reg_writeenable = 1;
            reg_byteenable = 4'b1111;
            reg_addr = rt;

        osdend

    end

    always_ff @ (posedge clk) begin
        
    end


endmodule