module top_module (
	input [4:1] x,
	output logic f
);
	always_comb begin
		case (x)
			4'b0000, 4'b0002, 4'b0003: f = 1'b0;      // d = don't-care, treated as 0 for these cases
			4'b0100: f = 1'b0;
			4'b0101: f = 1'b0;
			4'b0110: f = 1'b1;
			4'b0111: f = 1'b0;
			4'b1100: f = 1'b1;
			4'b1101: f = 1'b1;
			4'b1110, 4'b1111: f = 1'b0; // d = don't-care, treated as 0 for these cases
			4'b1000: f = 1'b1;
			4'b1001: f = 1'b1;
			4'b1010: f = 1'b0;
			default: f = 1'bx;          // invalid input scenario, undefined output
		endcase
	end
endmodule
