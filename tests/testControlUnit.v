module testControlUnit();
	reg [3:0] opCode;
	reg [3:0] function;
	wire branch; // are we branches? 1 for yes
	wire memRead; // are we reading memory? 1 for yes
	wire memToReg; // which value to write back to reg? 1 for memory, 0 for ALU
	wire [1:0] aluOP; // different for different instructions
	wire memWrite; // are we writing memory? 1 for yes
	wire aluSrc; // source for alu operand 2, 1 for immediate, 0 for register 2
	wire regWrite; // are we writing back to register? 1 for yes
	wire jump; // are we unconditional jumping? 1 for yes
	wire bne; // differentiate between beq and bne, 1 for bne, 0 for beq
	controlUnit myTestControlUnit(opCode, function, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, jump, bne);
	initial begin
		$monitor($time,,"opCode: %b, function: %b, %b-%b-%b-%b-%b-%b-%b-%b-%b", opCode, function, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, jump, bne);
		// add
		#10 opCode= 4'b0000; function= 4'b0000;
		// sub
		#10 opCode= 4'b0000; function= 4'b0001;
		// sll
		#10 opCode= 4'b0000; function= 4'b0010;
		// and
		#10 opCode= 4'b0000; function= 4'b0011;
		// lw
		#10 opCode= 4'b0001; function= 4'b1111;
		// sw
		#10 opCode= 4'b0010; function= 4'b1111;
		// addi
		#10 opCode= 4'b0011; function= 4'b1111;
		// beq
		#10 opCode= 4'b0100; function= 4'b1111;
		// bne
		#10 opCode= 4'b0101; function= 4'b1111;
		// jmp
		#10 opCode= 4'b0110; function= 4'b1111;
	end
endmodule