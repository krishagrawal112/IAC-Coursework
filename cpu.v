module control_path(
    input logic clk,
    input logic reset,
    output logic active,
    output logic[31:0] register_v0,
    );

    logic[5:0] opcode;

    initial begin
        state = 0;
    end


    typedef enum logic{
        FETCH = 1'b0;
        EXEC = 1'b1;
    } state;

    typedef enum logic[1:0]{


//implements state machine 
    always_ff @(posedge clk) begin
        
        if (state == 0)begin
            state <= 1;
        end
        else begin
            state <= 0;
        end

    end

    assign JType = (Opcode[5:1] == 5'b00001);
    assign IType;
    assign PCEn = (state == EXEC);
    assign IREn = (state == FETCH);
    assign AddrSrc = (state == FETCH);
    assign PCSrc1 = ((JumpAndBranchBool) == Jump || (JumpAndBranchBool == Branch));
    assign PCSrc2 =  

endmodule