module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case (x)
			4'b0000, 4'b0001, 4'b0101, 4'b0110: f = 1;
			default: f = 0;
		endcase
	end
	
endmodule
