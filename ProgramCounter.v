module ProgramCounter (
    input wire clk,                 // Clock signal
    input wire reset,               // Reset signal
    input wire [15:0] pc_in,        // Input value for the PC
    input wire pc_write_enable,     // Enable signal for writing to the PC
    output reg [15:0] pc_out        // Current value of the PC
);

    // On clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 16'b0;         // Reset the PC to 0
        else if (pc_write_enable)
            pc_out <= pc_in;         // Load the PC with a new value
        else
            pc_out <= pc_out + 16'b1; // Increment the PC by 1
    end
endmodule
