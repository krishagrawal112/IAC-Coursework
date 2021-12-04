module ALU(
    input logic [15:0] immediate,
    input logic [31:0] Rtdata,
    input logic signed [31:0] Rtsigned,
    input logic signed [31:0] Rssigned,
    input logic [31:0] Rsdata,
    
    
    input logic [4:0] sa,
    
    input logic addiu,
    input logic addu,
    input logic andr,
    input logic andi,
    input logic divu,
    input logic div,
    input logic multu,
    input logic mult,

    //2 new instructions  to implement
    //input logic mthi
    //input logic mtlo

    input logic orr,
    input logic ori,
    input logic sll,
    input logic sllv,
    input logic subu,
    input logic xorr,
    input logic xori,
    input logic sra,
    input logic srav,
    input logic srl,
    input logic srlv,
    input logic slt,
    input logic slti,
    input logic sltu,
    input logic sltiu,
    output logic reg_writeenable,
    output logic [31:0] data,
    output logic [31:0] data_lo,
    output logic [31:0] data_hi
    
    

);
assign data_lo = lo;
assign data_hi = hi;
 logic [31:0] signim;
 logic signed [31:0] signedim; 
 logic [31:0] zeroim;
 reg[31:0] lo;
 reg[31:0] hi;
 logic[31:0] datalo;
 logic[31:0] datahi;
 logic [31:0] temp1;
 logic [31:0] temp2;

 logic [63:0] multi;

 

 

    //Create non GPR HI and LO registers
    logic[31:0] HI;
    logic[31:0] LO;
    //Intermediary logic for mult operations
    logic[63:0] mult_temp, multu_temp;

    //assign mult_temp = ((state==EXEC)&&((instr_opcode==OPCODE_R)&&(instr_function==FUNCTION_MULT))) ? (regs[rs]*regs[rt]) : 0;
    //assign multu_temp = ((state==EXEC)&&((instr_opcode==OPCODE_R)&&(instr_function==FUNCTION_MULTU))) ? ($unsigned(regs[rs])*$unsigned(regs[rt])) : 0;
    //These 2 statements don't make sense to me. What is regs[rs] and regs[rt]? I Think you wrote this earlier and forgot to change things
    initial begin
        reg_writeenable = 0;
    end
    
    assign signim = { {16{immediate[15]}}, immediate };
    assign zeroim = { 16'b0000000000000000, immediate };
    assign signedim={ {16{immediate[15]}}, immediate };
    


always @* begin
    if (addiu==1)begin
        data = Rsdata + zeroim; //* Don't you need "+ signim" instead of "immediate"?
        reg_writeenable = 1;
    end

    if (addu==1) begin
        data = Rtdata + Rsdata;
        reg_writeenable = 1;
    end

    if (andr==1) begin
        data = Rtdata & Rsdata;
        reg_writeenable = 1;
    end

    if (andi==1)begin
        data = Rsdata & zeroim;
        reg_writeenable = 1;
    end

    if (divu==1)begin
        datalo= Rsdata/Rtdata; //*Logic divulo and divuhi referenced before assignment. Same for divhi and divlo. I think you mean datalo and datahi? 
        datahi=Rsdata%Rtdata;
    end


    if (div==1) begin
      datalo= Rssigned/Rtsigned;
      datahi= Rssigned%Rtsigned;
    end

    if (multu==1) begin
        multi= Rsdata*Rtdata; 
        datalo=multi[31:0];
        datahi=multi[63:32];
    end

    if (mult==1) begin
        multi= Rssigned*Rtsigned;
        datalo=multi[31:0];
        datahi=multi[63:32];
    end

    if (orr==1) begin
        data= Rtdata | Rsdata;
        reg_writeenable = 1;
    end

    if (ori==1) begin
        data= Rsdata | zeroim;
        reg_writeenable = 1;
    end

    if(sll==1) begin
        data= Rtdata<<sa;
        reg_writeenable = 1;
    end

    if (sllv==1)begin
        data= Rtdata<<Rsdata;
        reg_writeenable = 1;
    end

    if (subu==1) begin
        data= Rsdata-Rtdata;
        reg_writeenable = 1;
    end

    if (xorr==1) begin
        data= Rsdata^Rtdata;
        reg_writeenable = 1;
    end

    if (xori==1) begin
        data=Rsdata^zeroim;
        reg_writeenable = 1;
    end

    if (sra==1) begin
        data=Rtsigned>>>sa;
        reg_writeenable = 1;
    end

    if (srav==1) begin
        data=Rtsigned>>>Rsdata;
        reg_writeenable = 1;
    end

    if(srl==1) begin
        data=Rtdata>>sa;
        reg_writeenable = 1;
    end

    if (srlv==1)begin
        data=Rtdata>>Rsdata;
        reg_writeenable = 1;
    end
    
    if (slt==1) begin //We spoke about how this can be done simpler. Same for slti. Maybe you can change it to save 15-20 lines of code
        // if ((Rtdata[31]==1) && (Rsdata[31]==1)) begin
        //     temp1=~(Rtdata) +1;
        //     temp2=~(Rsdata) +1;
        //     if(temp1>temp2)begin
        //         data=0;
        //     end
        //     else begin
        //         data=1; 
        // end
        if(Rtsigned>Rssigned) begin
            data=1;
        end
        else begin
            data=0;
        end
        reg_writeenable = 1;
    end

    if (slti==1) begin
        // if ((signim[31]==1) && (Rsdata[31]==1)) begin
        //     temp1=~(signim) +1;
        //     temp2=~(Rsdata) +1;
        //     if(temp1>temp2) begin
        //         data=0;
        //     end
        //     else begin
        //         data=1;
        //     end

        // end
       if (Rssigned<signedim)begin
           data=1;
       end
       else begin
           data=0;
       end
        reg_writeenable = 1;
    end

    if (sltu==1) begin
        if (Rsdata<Rtdata)begin
            data=1;
        end
        else begin
            data=0;
        end
        reg_writeenable = 1;
    end
    
    if (sltiu==1) begin
        if (Rsdata<signim) begin
            data=1;
        end
        else begin

            data=0;
        end
        reg_writeenable = 1;
    end
    if(mult == 1 || div == 1 || divu == 1 || multu == 1)begin
        lo = datalo;
        hi = datahi;
    end
end
endmodule