module top_module (
	input [4:1] x,
	output logic f
);
	 
	always_comb begin
		case (x)
			4'b00??: f = 1; // Output 1 for all don't care entries
			4'b0100: f = 0;
			4'b0110: f = 1;
			4'b0111: f = 1;
			4'b10??: f = 0; // Output 0 for all don't care entries
			4'b1100: f = 1;
			4'b1101: f = 0;
			4'b111?: f = 1; // Output 1 for all don't care entries
			default: f = 0;
		endcase
	end
endmodule
