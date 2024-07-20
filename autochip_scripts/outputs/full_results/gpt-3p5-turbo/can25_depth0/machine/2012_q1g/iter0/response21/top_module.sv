module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case (x)
			4'h0: f = 1'b1;
			4'h1: f = 1'b1;
			4'h2: f = 1'b0;
			4'h3: f = 1'b0;
			4'h4: f = 1'b1;
			4'h5: f = 1'b1;
			4'h6: f = 1'b1;
			4'h7: f = 1'b0;
			4'h8: f = 1'b0;
			4'h9: f = 1'b0;
			4'ha: f = 1'b0;
			4'hb: f = 1'b0;
			4'hc: f = 1'b1;
			4'hd: f = 1'b0;
			4'he: f = 1'b1;
			4'hf: f = 1'b1;
		endcase
	end
endmodule
