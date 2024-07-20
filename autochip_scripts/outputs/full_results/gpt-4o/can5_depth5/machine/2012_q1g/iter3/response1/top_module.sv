module top_module (
	input [4:0] x,  // Correct input width to 5 bits
	output logic f
);

	always_comb begin
		case (x[3:0])  // Only consider the lower 4 bits
			4'b0000: f = 1;
			4'b0001: f = 1;
			4'b0010: f = 0;
			4'b0011: f = 0;
			4'b0100: f = 1;
			4'b0101: f = 1;
			4'b0110: f = 1;
			4'b0111: f = 0;
			4'b1000: f = 0;
			4'b1001: f = 0;
			4'b1010: f = 0;
			4'b1011: f = 0;
			4'b1100: f = 1;
			4'b1101: f = 0;
			4'b1110: f = 1;
			4'b1111: f = 1;
			default:  f = 0;  // Default case in case x is outside 0x0 to 0xF
		endcase
	end

endmodule
