module RAM(
    
);

reg[7:0] memory [31:0];
integer i;
initial begin
    $readmemh("test1.txt", memory);
    for (i = 0; i < 32; i++) begin
        $display("%h: %h", i, memory[i]);
    end
end
endmodule