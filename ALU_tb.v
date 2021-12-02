module ALU_tb();
    logic [15:0] immediate;
    logic [31:0] Rtdata;
    logic [31:0] Rsdata;

    
    logic [4:0] sa;
    
    logic addiu;
    logic addu;
    logic andr;
    logic andi;
    logic divu;
    logic div;
    logic multu;
    logic mult;

    //2 new instructions  to implement
    //input logic mthi
    //input logic mtlo

    logic orr;
    logic ori;
    logic sll;
    logic sllv;
    logic subu;
    logic xorr;
    logic xori;
    logic sra;
    logic srav;
    logic srl;
    logic srlv;
    logic slt;
    logic slti;
    logic sltu;
    logic sltiu;
    logic reg_writeenable;
    logic [31:0] data;
    logic [31:0] datalo;
    logic [31:0] datahi;
    
    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        addu=1; Rtdata=1; Rsdata=1;
        #1;
        assert(data==2);
        assert(reg_writeenable==1);
        addu=0;

        orr=1; Rtdata=9; Rsdata=10;
        #1;
        assert(data==11);
        assert(reg_writeenable==1);

        
    end

    ALU dut(
        .immediate(immediate),
        .Rtdata(Rtdata),
        .Rsdata(Rsdata),
        .sa(sa),
        .addiu(addiu),
        .addu(addu),
        .andr(andr),
        .andi(andi),
        .divu(divu),
        .div(div),
        .multu(multu),
        .mult(mult),
        .orr(orr),
        .ori(ori),
        .sll(sll),
        .sllv(sllv),
        .subu(subu),
        .xorr(xorr),
        .xori(xori),
        .sra(sra),
        .srav(srav),
        .srl(srl),
        .srlv(srlv),
        .slt(slt),
        .slti(slti),
        .sltu(sltu),
        .sltiu(sltiu),
        .reg_writeenable(reg_writeenable),
        .data(data),
        .datalo(datalo),
        .datahi(datahi)
    );
          
endmodule