`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ALU (
    input [15:0] A,    // First operand
    input [15:0] B,    // Second operand
    output reg [15:0] Result, // ALU output
    output Zero        // Zero flag
);

 // ALU operations
    always @(*) begin
        case(ALUOp)
            3'b000: Result = A + B;   // ADD
            3'b001: Result = A - B;   // SUBTRACT
            3'b010: Result = A & B;   // AND
            3'b011: Result = A | B;   // OR
 
          
            default: Result = 16'b0;  // Default case
        endcase
    end

    // Zero flag
    assign Zero = (Result == 16'b0) ? 1'b1 : 1'b0;

endmodule
