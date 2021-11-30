module ALU(
    input logic [31:0] instruction,
    input logic [31:0] Rtdata,
    input logic [31:0] Rsdata,

    input logic [15:0] immediate,
    input logic [4:0] sa,
    
    input logic addiu,
    input logic addu,
    input logic andr,
    input logic andi,
    input logic div,
    input logic divu,
    input logic mult,
    input logic multu,
    input logic orr,
    input logic ori,
    input logic sll,
    input logic sllv,
    input logic slt,
    input logic slti,
    input logic sltiu,
    input logic sltu,
    input logic sra,
    input logic srav,
    input logic srl,
    input logic srlv,
    input logic subu,
    input logic xorr,
    input logic xori,
    output logic [31:0] data,
    output logic [31:0] datalo,
    output logic [31:0] datahi,
    output logic [63:0] mult

);
 logic [31:0] signim;
 logic[31:0] zeroim;
 
 logic [31:0] temp1;
 logic [31:0] temp2;

    //Create non GPR HI and LO registers
    logic[31:0] HI;
    logic[31:0] LO;
    //Intermediary logic for mult operations
    logic[63:0] mult_temp, multu_temp;
    assign mult_temp = ((state==EXEC)&&((instr_opcode==OPCODE_R)&&(instr_function==FUNCTION_MULT))) ? (regs[rs]*regs[rt]) : 0;
    assign multu_temp = ((state==EXEC)&&((instr_opcode==OPCODE_R)&&(instr_function==FUNCTION_MULTU))) ? ($unsigned(regs[rs])*$unsigned(regs[rt])) : 0;
    assign zeroim[31:16] =0;
    assign zeroim[15:0]=immediate;
    assign signim[15:0]=immediate;
    


always comb begin
    if(immediate[15]==1) begin
        signim[31:16]= 16x0b1111111111111111;
    end
    else begin
        signim[31:16]=0;
    end

    if (addiu==1)begin
      data=Rsdata + immediate;
    end

    if (addu==1) begin
      data=Rtdata + Rsdata;
    end

    if (andr==1) begin
     data= Rtdata & Rsdata;
    end

    if (andi==1)begin
     data= Rsdata & zeroim;
    end

    if (divu==1)begin
      divuhi= Rsdata/Rtdata;
      divulo=Rsdata%Rtdata;
    end


    if (div==1) begin
    if ((Rsdata[31]==1) && (Rtdata[31]==1)) begin
        temp1= ~(Rsdata)+1;
        temp2= ~(Rtdata)+1;
        divlo= temp1/temp2;
        divhi= (temp1 % temp2)*(-1);
    end
    else if (Rsdata[31]==1)begin
        temp1= ~(Rsdata)+1;
        divlo=(temp1/Rtdata)*(-1);
        divhi=(temp1% Rtdata)*(-1);
    end
    else if(Rtdata[31]==1)begin
        temp2= ~(Rtdata) +1;
        divlo=(Rsdata/temp2)*(-1);
        divhi= Rsdata%temp2;
    end
    else begin
        divlo= Rsdata/Rtdata;
        divhi= Rsdata%Rtdata;
    end
    end

    if (multu==1) begin
     data= Rsdata*Rddata;
    end

    if (mult==1) begin
    if ((Rsdata[31]==1) && (Rtdata[31]==1)) begin
        temp1= ~(Rsdata)+1;
        temp2= ~(Rtdata)+1;
        mult=temp1*temp2;

    end
    else if (Rsdata[31]==1)begin
        temp1= ~(Rsdata)+1;
        mult= (temp1*Rtdata)*(-1);
        
    end
    else if(Rtdata[31]==1)begin
        temp2= ~(Rtdata) +1;
        mult=(temp2*Rsdata)*(-1);
    end
    else begin
        mult=Rsdata*Rtdata;
    end
    end

    if (orr==1) begin
    data= Rtdata | Rsdata;
    end

    if (ori-==1) begin
    data= Rsdata | zeroim;
    end

    if(sll==1) begin
     data= Rtdata<<sa;
    end

    if (sllv==1)begin
     data= Rtdata<<Rsdata;
    end

    if (subu==1) begin
     data= Rsdata-Rtdata;
    end

    if (xorr==1) begin
     data= Rsdata^Rtdata;
    end

    if (xori==1) begin
     data=Rsdata^zeroim;
    end

    if (sra==1) begin
     data=Rtdata>>>sa;
    end

    if (srav==1) begin
     srav=Rtdata>>>Rsdata;
    end

    if(srl==1) begin
     srl=Rtdata>>sa;
    end

    if (srlv==1)begin
     srlv=Rtdata>>Rsdata;
    end
    
    if (slt==1) begin
    if ((Rtdata[31]==1) && (Rsdata[31]==1)) begin
        temp1=~(Rtdata) +1;
        temp2=~(Rsdata) +1;
        if(temp1>temp2)begin
            data=0;
        end
        else begin
            data=1
        end

    end
    else if ((Rtdata[31]==1))begin
        data=0;
    end
    else if (Rsdata[31]==1) begin
        data=1;
    end
    else begin
        if (Rsdata<Rtdata) begin
            data=1;
        end
        else begin
            data=0;
        end
    end
    end

    if (slti==1) begin
    if ((signim[31]==1) && (Rsdata[31]==1)) begin
        temp1=~(signim) +1;
        temp2=~(Rsdata) +1;
        if(temp1>temp2) begin
            data=0
        end
        else begin
            data=1;
        end

    end
    else if (signim[31]==1))begin
        data=0;
    end
    else if (Rsdata[31]==1) begin
        data=1;
    end
    else begin
        if (Rsdata<signim) begin
            data=1;
        end
        else begin
            data=0;
        end
    end
    end

    if (sltu==1) begin
    if (Rsdata<Rtdata)begin
        data=1;
    end
    else begin
        data=0;
    end
    end
    //do Sltui

end
endmodule