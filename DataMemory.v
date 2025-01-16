module DataMemory (
    input [7:0] address,         // 8-bit address for the data
    input [15:0] writeData,      // Data to write into memory
    input memRead,               // Signal to read from memory
    input memWrite,              // Signal to write to memory
    output reg [15:0] readData   // Data read from memory
);

    // Declare data memory (256 x 16-bit memory)
    reg [15:0] memory [255:0];

    // On write, store data into memory
    always @(posedge memWrite) begin
        memory[address] <= writeData; // Store writeData at the specified address
    end

    // On read, fetch data from memory
    always @(posedge memRead) begin
        readData <= memory[address]; // Read data from the specified address
    end

endmodule