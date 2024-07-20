module top_module (
		input [3:0] x,
		output logic f
	);
		always_comb begin
			case (x)
				4'b00??: f = 1'b0;
				4'b0100: f = 1'b0;
				4'b0101: f = 1'b1;
				4'b0110: f = 1'b0;
				4'b0111: f = 1'b1;
				4'b10??: f = 1'b1;
				4'b110?: f = 1'b1;
				default: f = 1'b0;
			endcase
		end
	endmodule
