module ALU_tb();
    logic [15:0] immediate;
    logic [31:0] Rtdata;
    logic signed [31:0] Rtsigned;
    logic signed [31:0] Rssigned;
    logic [31:0] Rsdata;

    
    logic [4:0] sa;
    logic clk;
    logic [1:0] state;
    
    logic addiu;
    logic addu;
    logic andr;
    logic andi;
    logic divu;
    logic div;
    logic multu;
    logic mult;
    logic mthi;
    logic mtlo;

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
        clk=0;
        state=0;

        
        repeat (1000) begin
            #10; clk = 1;
            case(state)
                2'b00: state = 2'b01;
                2'b01: state = 2'b10;
                2'b10: state = 2'b00;
                default: state = 2'b00;
            endcase 
            #10; clk = 0;
        end
    end
    initial begin

        addiu=1;Rtdata=5; immediate=1; Rsdata= 10;
        #1;
        assert(data==11);
        assert(reg_writeenable==1);
        addiu=0;

        addu=1; Rtdata=1; Rsdata=1;
        #1;
        assert(data==2);
        assert(reg_writeenable==1);
        addu=0;

        andr=1; Rtdata=429496729;Rsdata=10; 
        #1;
        assert(data==8);
        assert(reg_writeenable==1);
        andr=0;

        andi=1; Rsdata=11; immediate=3;
        #1;
        assert(data==3);
        assert(reg_writeenable==1);
        andi=0;

        divu=1; Rsdata=32'h80000000; Rtdata= 3;
        #1;
        divu=0;

        mtlo=1;
        #1;
        assert(data==32'h2AAAAAAA);
        mtlo=0;

        mthi=1;
        #1;
        assert(data==2);
        mthi=0;

        div=1; Rssigned=32'h80000000; Rtsigned=3;
        #1;
        div=0;

        mtlo=1;
        #1;
        assert(data==32'hd5555556);
        mtlo=0;

        mthi=1;
        #1;
        assert(data==32'hfffffffe);
        mthi=0;

        multu=1; Rsdata=32'hab3df781; Rtdata=32'hfb9a6c3d;
        #1;
        multu=0;

        mtlo=1;
        #1;
        assert(data==32'h50C865BD);
        mtlo=0;

        mthi=1;
        #1;
        assert(data==32'hA84D0D59);
        mthi=0;

        mult=1; Rssigned=32'hf1a5b3c9; Rtsigned=32'h1abffc7a;
        #1;
        mult=0;

        mtlo=1;
        #1;
        assert(data==32'hD2E889CA);
        mtlo=0;

        mthi=1;
        #1;
        assert(data==32'hFE8010BB);
        mthi=0;


        orr=1; Rtdata=9; Rsdata=10;
        #1;
        assert(data==11);
        assert(reg_writeenable==1);
        orr=0;

        ori=1;Rsdata=32'hffffff00;immediate=16'h0003;
        #1;
        assert(data==32'hffffff03);
        ori=0;

        sll=1;Rtdata=32'h00000001;sa=4;
        #1;
        assert(data==32'h00000010);
        sll=0;

        sllv=1;Rtdata=32'h00000001;Rsdata=8;
        #1;
        assert(data==32'h00000100);
        sllv=0;

        subu=1; Rsdata=2147483648; Rtdata=3;
        #1;
        assert(data==2147483645);
        subu=0;

        xorr=1; Rsdata=32'h00000001; Rtdata=32'h4afcab60;;
        #1;
        assert(data==32'h4afcab61);
        xorr=0;

        xori=1; Rsdata=32'h30ff0e15; immediate=16'h7f06;
        #1;
        assert(data==32'h30ff7113);
        xori=0;

        sra=1; Rtsigned=32'hf000000f; sa=4;
        #1;
        assert(data==32'hff000000);
        sra=0;

        srav=1; Rtsigned=32'hf0000000; Rsdata=8;
        #1;
        assert(data==32'hfff00000);
        srav=0;

        srl=1; Rtdata=32'hf0000000; sa=4;
        #1;
        assert(data==32'h0f000000);
        srl=0;

        srlv=1; Rtdata=32'hf0000000; Rsdata=8;
        #1;
        assert(data==32'h00f00000);
        srlv=0;

        slt=1; Rssigned=32'hf1100123; Rtsigned=32'h73ff0981;
        #1;
        assert(data==1);
        slt=0;

        slti=1; Rssigned=32'h0119cdaf; immediate=16'hf001;
        #1;
        assert(data==0);
        slti=0;

        sltu=1; Rtdata=32'hfa012201; Rsdata=32'hea81fa09;
        #1;
        assert(data==1);
        sltu=0;

        sltiu=1; Rsdata=32'h0119cdaf; immediate=16'hf001;
        #1;
        assert(data==1);
        sltiu=0;



        
    end


    ALU dut(
        .immediate(immediate),
        .Rtdata(Rtdata),
        .Rtsigned(Rtsigned),
        .Rssigned(Rssigned),
        .Rsdata(Rsdata),
        .sa(sa),
        .clk(clk),
        .state(state),
        .addiu(addiu),
        .addu(addu),
        .andr(andr),
        .andi(andi),
        .divu(divu),
        .div(div),
        .multu(multu),
        .mult(mult),
        .mthi(mthi),
        .mtlo(mtlo),
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
        .data(data)
    );
          
endmodule