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
    output logic [31:0] datahi

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
    divuhi= Rsdata/Rtdata;
    divulo=Rsdata%Rtdata;

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

    multu= Rsdata*Rddata;
    
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

    bitor= Rtdata | Rsdata;
    bitori= Rsdata | immediate;
    sll= Rtdata<<sa;
    sllv= Rtdata<<Rsdata;
    subu= Rsdata-Rtdata;
    exor= Rsdata^Rtdata;
    exori=Rsdata^imediade;
    sra=Rtdata>>>sa;
    srav=Rtdata>>>Rsdata;
    srl=Rtdata>>sa;
    srlv=Rtdata>>Rsdata;

    if ((Rtdata[31]==1) && (Rsdata[31]==1)) begin
        temp1=~(Rtdata) +1;
        temp2=~(Rsdata) +1;
        if(temp1>temp2)begin
            slt=0;
        end
        else begin
            slt=1
        end

    end
    else if ((Rtdata[31]==1))begin
        slt=0;
    end
    else if (Rsdata[31]==1) begin
        slt=1;
    end
    else begin
        if (Rsdata<Rtdata) begin
            slt=1;
        end
        else begin
            slt=0;
        end
    end


    if ((immediate[31]==1) && (Rsdata[31]==1)) begin
        temp1=~(immediate) +1;
        temp2=~(Rsdata) +1;
        if(temp1>temp2) begin
            slti=0
        end
        else begin
            slti=1;
        end

    end
    else if (immediate[31]==1))begin
        slti=0;
    end
    else if (Rsdata[31]==1) begin
        slti=1;
    end
    else begin
        if (Rsdata<immediate) begin
            slti=1;
        end
        else begin
            slti=0;
        end
    end

    if (Rsdata<Rtdata)begin
        sltu=1;
    end
    else begin
        sltu=0;
    end

end
endmodule