module top_module (
	input [4:1] x,
	output logic f
);
	always_comb begin
		case (x)
			4'h0: f = 'x;
			4'h1: f = 'x;
			4'h2: f = 0;
			4'h3: f = 'x;
			4'h4: f = 1;
			4'h5: f = 'x;
			4'h6: f = 1;
			4'h7: f = 0;
			4'h8: f = 0;
			4'h9: f = 0;
			4'ha: f = 'x;
			4'hb: f = 1;
			4'hc: f = 1;
			4'hd: f = 'x;
			4'he: f = 1;
			4'hf: f = 'x;
			default: f = 'x;
		endcase
	end
endmodule
