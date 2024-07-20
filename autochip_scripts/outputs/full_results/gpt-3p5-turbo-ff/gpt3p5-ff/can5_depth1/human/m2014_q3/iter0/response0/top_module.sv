module top_module (
	input [4:1] x,
	output logic f
);
	
	always_comb begin
		case (x)
			4'b00xx: f = 1'b0;
			4'b01xx: f = 1'b0;
			4'b11xx: f = 1'b1;
			4'b10xx: f = 1'b1;
			4'bxxxx: f = 1'b0; // don't-care case
		endcase
	end

endmodule
