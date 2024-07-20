module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		f = 1'b0;
		
		case (x)
			4'b01x0: f = 1'b0;
			4'b01x1: f = 1'b1;
			4'b0101: f = 1'b1;
			4'b0110, 4'b0111: f = 1'b0;
			default: f = 1'b0;
		endcase
	end
endmodule
