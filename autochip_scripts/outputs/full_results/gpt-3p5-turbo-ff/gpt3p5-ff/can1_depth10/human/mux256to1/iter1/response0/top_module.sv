module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
  
	reg [255:0] in_reg; // Create a register to store the input

	always @(in) begin
		in_reg <= in; // Assign input to the register
	end

	always @(sel or in_reg) begin
		case(sel)
			8'b00000000: out <= in_reg[0];
			8'b00000001: out <= in_reg[1];
			8'b00000010: out <= in_reg[2];
			8'b00000011: out <= in_reg[3];
			8'b00000100: out <= in_reg[4];
			8'b00000101: out <= in_reg[5];
			8'b00000110: out <= in_reg[6];
			8'b00000111: out <= in_reg[7];
			// Add cases for all 256 inputs
			default: out <= 1'b0;
		endcase
	end

endmodule
