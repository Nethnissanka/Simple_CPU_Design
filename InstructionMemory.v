`timescale 1ns / 1ps

module InstructionMemory (
    input [15:0] address,     // Address of the instruction (comes from PC)
    output reg [15:0] instruction // Output the instruction at the given address
);

    // Declare the instruction memory (for example, 256 x 16-bit memory)
    reg [15:0] memory [255:0];  // Memory to hold up to 256 instructions, each 16-bit

    // Initialize the memory with a program (you can replace this with your own instructions)
    initial begin
        // Simple program example
        memory[0] = 16'b0000000000000001; // Example instruction
        memory[1] = 16'b0000000000000010; // Example instruction
        memory[2] = 16'b0000000000000011; // Example instruction
        memory[3] = 16'b0000000000000100; // Example instruction
        // Add more instructions as needed...
    end

    // On every address change, fetch the instruction from memory
    always @(*) begin
        instruction = memory[address];  // Fetch instruction at given address
    end

endmodule
