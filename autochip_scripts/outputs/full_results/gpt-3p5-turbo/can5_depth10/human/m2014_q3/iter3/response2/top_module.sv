module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		case (x)
			4'bxxxx: f = 1'b1;
			4'bxx00: f = 1'b0;
			4'bxx01: f = 1'b0;
			4'bxx10: f = 1'b1;
			4'bxx11: f = 1'b0;
			4'b00xx: f = 1'b0;
			4'b00x0: f = 1'b0;
			4'b00x1: f = 1'b0;
			4'b0100: f = 1'b0;
			4'b0101: f = 1'b1;
			4'b0110: f = 1'b1;
			4'b0111: f = 1'b0;
			4'b10xx: f = 1'b1;
			4'b1100: f = 1'b1;
			4'b1101: f = 1'b0;
			default: f = 1'b0;
		endcase
	end
endmodule
