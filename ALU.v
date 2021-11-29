module ALU(
    input logic [31:0] instruction,
    input logic [31:0] Rmdata,
    input logic [31:0] Rtdata,
    input logic [31:0] Rsdata,
    output logic [31:0] datalo,
    output logic [31:0]  datahi

);
 logic [5:0] type;
 logic [31:0] temp1;
 logic [31:0] temp2;
 logic [4:0] Rsadd;
 logic [4:0] Rtadd;
 logic [15:0] immediate;
 logic [4:0] Rmadd;
 logic [5:0] op;
 logic[31:0] addi;
 logic [31:0] add;
 logic[31:0] bitand;
 logic[31:0] bitandi;
 logic[31:0] divlo;
 logic[31:0] divhi;
 logic[31:0] divulo;
 logic[31:0] divuhi;

 assign type = instruction[31:26];
 assign immediate = instruction[15:0];


always comb begin
    addiout=Rtdata + immediate;
    addout=Rtdata + Rmdata;
    bitand= Rtdata & Rmdata;
    bitandi= Rtdata & immediate;
    divuhi= Rsdata/Rtdata;
    divulo=Rsdata%Rtdata;

    if ((Rsdata[31]==1) && (Rtdata[31]==1)) begin
        temp1= ~(Rsdata)+1;
        temp2= ~(Rtdata)+1;
        divlo= temp1/temp2;
        divhi= ~(temp1 % temp2)+1

    end
    else if (Rsdata[31]==1)begin
        temp1= ~(Rsdata)+1;
        divlo=~(temp1/Rtdata)+1;
        divhi=~(temp1% Rtdata)+1;
    end
    else if(Rtdata[31]==1)begin
        temp2= ~(Rtdata) +1;
        divlo=~(Rsdata/temp2) +1;
        divhi= Rsdata%temp2;
    end
    else begin
        divlo= Rsdata/Rtdata;
        divhi= Rsdata%Rtdata;
    end






end
