module ControlUnit (
    input [3:0] opcode,        // 4-bit opcode from the instruction
    output reg regWrite,       // Control signal to write to the register
    output reg memRead,        // Control signal to read from memory
    output reg memWrite,       // Control signal to write to memory
    output reg [2:0] aluOp,    //ALU operation control signal
    output reg jump            // Control signal for jump instruction
);

always @(*) begin
  
    regWrite = 0;
    memRead = 0;
    memWrite = 0;
    aluOp = 3'b000; 
    jump = 0;

    case (opcode)
        4'b0000: begin  // Add
            regWrite = 1;
            aluOp = 3'b000;  // Set Alu to Perform Addition
        end

        4'b0001: begin  // Sub 
            regWrite = 1;
            aluOp = 3'b001;  // Set Alu to Perform Subtraction
        end

        4'b0010: begin  // Load 
            memRead = 1;
            regWrite = 1;
        end

        4'b0011: begin  // Store 
            memWrite = 1;
        end

        4'b0100: begin  // Jump 
            jump = 1;
        end

        default: begin
            
        end
    endcase
end

endmodule
