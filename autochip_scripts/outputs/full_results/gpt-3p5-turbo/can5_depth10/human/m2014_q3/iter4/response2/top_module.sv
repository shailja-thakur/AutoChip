module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		f = 1'b0;
		
		case (x)
			4'b01?0: f = 1'b0;
			4'b01?1: f = 1'b1;
			4'b0101: f = 1'b1;
			4'b011?: f = 1'b1;
			4'b11?0: f = 1'b1;
			4'b1100: f = 1'b1;
			4'b11?1: f = 1'b0;
			default: f = 1'b0;
		endcase
	end
endmodule
