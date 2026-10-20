module controlUnit (opCode, function, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, jump, bne);
	input [3:0] opCode;
	input [3:0] function;
	output reg branch; // are we branches? 1 for yes
	output reg memRead; // are we reading memory? 1 for yes
	output reg memToReg; // which value to write back to reg? 1 for memory, 0 for ALU
	output reg [1:0] aluOP; // different for different instructions
	output reg memWrite; // are we writing memory? 1 for yes
	output reg aluSrc; // source for alu operand 2, 1 for immediate, 0 for register 2
	output reg regWrite; // are we writing back to register? 1 for yes
	output reg jump; // are we unconditional jumping? 1 for yes
	output reg bne; // differentiate between beq and bne, 1 for bne, 0 for beq
	always @(*) begin
		branch = 0;
		memRead = 0;
		memToReg = 0;
		aluOP = 2'b00;
		memWrite = 0;
		aluSrc = 0;
		regWrite = 0;
		jump = 0;
		bne = 0;

		if (opCode != 4'b0000) begin // if the opCode ISNT R-type (handle all i/j type)
			// lw
			if (opCode == 4'b0001) begin
				branch= 0;
				memRead= 1;
				memToReg= 1;
				aluOP= 2'b00;
				memWrite= 0;
				aluSrc= 1;
				regWrite= 1;
				jump= 0;
				bne = 0;
			end
			// sw
			else if (opCode == 4'b0010) begin
				branch= 0;
				memRead= 0;
				memToReg= 1; // X
				aluOP= 2'b00;
				memWrite= 1;
				aluSrc = 1;
				regWrite = 0;
				jump = 0;
				bne = 0;
			end
			// addi
			else if (opCode == 4'b0011) begin
				branch= 0;
				memRead= 0;
				memToReg= 0;
				aluOP= 2'b00;
				memWrite= 0;
				aluSrc= 1;
				regWrite= 1;
				jump= 0;
				bne = 0;
			end
			// beq
			else if (opCode == 4'b0100) begin
				branch= 1;
				memRead= 0;
				memToReg= 0; // X
				aluOP= 2'b01;
				memWrite= 0;
				aluSrc= 0;
				regWrite= 0;
				jump= 0;
				bne = 0;
			end
			// bne
			else if (opCode == 4'b0101) begin
				branch= 1;
				memRead= 0;
				memToReg= 0; // X
				aluOP= 2'b01;
				memWrite= 0;
				aluSrc= 0;
				regWrite= 0;
				jump= 0;
				bne = 1;
			end
			// jmp (0110)
			else if (opCode == 4'b0110) begin
				branch= 0;
				memRead= 0;
				memToReg= 0; // X
				aluOP= 2'b00; // X
				memWrite= 0;
				aluSrc= 0; // X
				regWrite= 0;
				jump= 1;
				bne = 0;
			end
		end
		else begin // if opCode is R-type (all R-type codes have the same variables)
			// add
			if(function == 4'b0000) begin
				branch = 0;
				memRead = 0;
				memToReg = 0;
				aluOP = 2'b00;
				memWrite = 0;
				aluSrc = 0;
				regWrite = 1;
				jump = 0;
				bne = 0;
			end
			// sub
			else if (function == 4'b0001) begin
				branch = 0;
				memRead = 0;
				memToReg = 0;
				aluOP = 2'b01;
				memWrite = 0;
				aluSrc = 0;
				regWrite = 1;
				jump = 0;
				bne = 0;
			end
			// sll
			else if (function == 4'b0010) begin
				branch = 0;
				memRead = 0;
				memToReg = 0;
				aluOP = 2'b10;
				memWrite = 0;
				aluSrc = 0;
				regWrite = 1;
				jump = 0;
				bne = 0;
			end
			// and
			else if (function == 4'b0011) begin
				branch = 0;
				memRead = 0;
				memToReg = 0;
				aluOP = 2'b11;
				memWrite = 0;
				aluSrc = 0;
				regWrite = 1;
				jump = 0;
				bne = 0;
			end
		end
	end
endmodule