module CPU (
    input wire clk,
    input wire reset
);
    // Internal wires for interconnections
    wire [15:0] pc_in, pc_out;
    wire [15:0] instruction;
    wire [3:0] opcode;
    wire [2:0] reg1, reg2, write_reg;
    wire [15:0] immediate;
    wire [2:0] alu_op;
    wire [15:0] read_data1, read_data2, alu_result, mem_data;
    wire reg_write, mem_read, mem_write, jump, zero_flag;

    // Instantiate Program Counter
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_write_enable(1'b1),  // Always enable for simplicity
        .pc_out(pc_out)
    );

    // Instantiate Instruction Memory
    InstructionMemory IM (
        .address(pc_out),
        .instruction(instruction)
    );

	 // Decode instruction fields
    assign opcode = instruction[15:12];     // Assume opcode in higher bits
    assign reg1 = instruction[11:9];        // First operand register
    assign reg2 = instruction[8:6];         // Second operand register
    assign write_reg = instruction[5:3];    // Destination register
    assign immediate = instruction[7:0];    // Immediate value (if needed)

    // Instantiate Control Unit
    ControlUnit CU (
        .opcode(opcode),
        .regWrite(reg_write),
        .memRead(mem_read),
        .memWrite(mem_write),
        .aluOp(alu_op),
        .jump(jump)
    );

    // Instantiate Register File
    RegisterFile RF (
        .clk(clk),
        .read_reg1(reg1),
        .read_reg2(reg2),
        .write_reg(write_reg),
        .write_data(mem_data),   // Data to write from DataMemory
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

	// ALU operation based on aluOp signal
    ALU ALU (
        .A(read_data1),
        .B(read_data2),
        .ALUOp(alu_op),
        .Result(alu_result),
        .Zero(zero_flag)
    );

    // Instantiate Data Memory
    DataMemory DM (
        .address(alu_result[7:0]), // Use lower 8 bits of ALU result as address
        .writeData(read_data2),    // Write the data from second register
        .memRead(mem_read),
        .memWrite(mem_write),
        .readData(mem_data)        // Data read from memory
    );

    // Control the Program Counter
    assign pc_in = (jump) ? immediate : pc_out + 1;

endmodule
