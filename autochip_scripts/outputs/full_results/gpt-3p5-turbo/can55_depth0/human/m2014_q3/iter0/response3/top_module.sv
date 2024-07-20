module top_module (
	input [4:1] x,
	output logic f
);
	always_comb begin
		case (x)
			4'b00xx: f = 0; // Don't care inputs
			4'b01xx: f = 0; // Don't care inputs
			4'b11xx: f = 1; // Don't care inputs
			4'b10xx: f = 1; // Don't care inputs
			4'b00x0: f = 0;
			4'b0101: f = 1;
			4'b0110: f = 0;
			4'b110x: f = 1; // Don't care inputs
			4'b10x1: f = 0; // Don't care inputs
			default: f = 0; // Assign default value
		endcase
	end
endmodule
