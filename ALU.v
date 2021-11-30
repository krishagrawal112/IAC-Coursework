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
    output logic data,
    output logic [31:0] datalo,
    output logic [31:0] datahi,
    output logic [63:0] mult

);
 logic [31:0] signim;
 
 logic [31:0] temp1;
 logic [31:0] temp2;


 logic [31:0] addi;
 logic [31:0] add;
 logic [31:0] bitand;
 logic [31:0] bitandi;
 logic [31:0] divlo;
 logic [31:0] divhi;
 logic [31:0] divulo;
 logic [31:0] divuhi;
 logic [63:0] mult;
 logic [63:0] multu;
 logic [31:0] bitor;
 logic [31:0] bitori;
 logic [31:0] sll;
 logic [31:0] sllv;
 logic [31:0] sra;
 logic [31:0] srav;
 logic [31:0] srl;
 logic [31:0] srlv;
 logic [31:0] subu;
 logic [31:0] exor;
 logic [31:0] exori;
 logic [31:0] slt;
 logic [31:0] slti;
 logic [31:0] sltui;
 logic [31:0] sltu;





always comb begin

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
     data= Rsdata & immediate;
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
    data= Rsdata | immediate;
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
     data=Rsdata^imediade;
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
    if ((immediate[31]==1) && (Rsdata[31]==1)) begin
        temp1=~(immediate) +1;
        temp2=~(Rsdata) +1;
        if(temp1>temp2) begin
            data=0
        end
        else begin
            data=1;
        end

    end
    else if (immediate[31]==1))begin
        data=0;
    end
    else if (Rsdata[31]==1) begin
        data=1;
    end
    else begin
        if (Rsdata<immediate) begin
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
    #do Sltui

end
endmodule