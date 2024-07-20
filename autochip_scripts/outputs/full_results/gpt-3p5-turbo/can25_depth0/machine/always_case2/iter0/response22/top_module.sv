module top_module (
	input [3:0] in,
	output reg [1:0] pos
);
	always @(in) begin
		case (in)
			4'b0000: pos <= 2'b00; // if "in" is 0, "pos" will be set to 0.
			4'b0001: pos <= 2'b00; // if "in" is 1, "pos" will be set to 0.
			4'b0010: pos <= 2'b01; // if "in" is 2, "pos" will be set to 1.
			4'b0011: pos <= 2'b00; // if "in" is 3, "pos" will be set to 0.
			4'b0100: pos <= 2'b10; // if "in" is 4, "pos" will be set to 2.
			4'b0101: pos <= 2'b00; // if "in" is 5, "pos" will be set to 0.
			4'b0110: pos <= 2'b01; // if "in" is 6, "pos" will be set to 1.
			4'b0111: pos <= 2'b00; // if "in" is 7, "pos" will be set to 0.
			4'b1000: pos <= 2'b11; // if "in" is 8, "pos" will be set to 3.
			4'b1001: pos <= 2'b00; // if "in" is 9, "pos" will be set to 0.
			4'b1010: pos <= 2'b01; // if "in" is 10, "pos" will be set to 1.
			4'b1011: pos <= 2'b00; // if "in" is 11, "pos" will be set to 0.
			4'b1100: pos <= 2'b10; // if "in" is 12, "pos" will be set to 2.
			4'b1101: pos <= 2'b00; // if "in" is 13, "pos" will be set to 0.
			4'b1110: pos <= 2'b01; // if "in" is 14, "pos" will be set to 1.
			4'b1111: pos <= 2'b00; // if "in" is 15, "pos" will be set to 0.
			default: pos <= 2'b00; // In all other cases "pos" will be set to 0.
		endcase
	end
endmodule
