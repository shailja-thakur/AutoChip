module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		case (x)
			4'h0: f = 1'bx;
			4'h1, 4'h3, 4'ha, 4'hd, 4'hf: f = 1'bx;
			4'h2, 4'h6, 4'h7, 4'h8, 4'h9: f = 0;
			4'h4, 4'hb, 4'hc, 4'he: f = 1;
		endcase
	end

endmodule
