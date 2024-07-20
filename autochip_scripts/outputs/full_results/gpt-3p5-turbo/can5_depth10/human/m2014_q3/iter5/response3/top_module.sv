module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		f = 1'b0;
		
		case (x)
			4'b00xx: f = 1'b0;
			4'b01x1: f = 1'b1;
			4'b1011: f = 1'b1;
			4'b11x0: f = 1'b1;
			4'b1100: f = 1'b1;
			4'b1101: f = 1'b0;
			default: f = 1'bz;
		endcase
	end
endmodule
