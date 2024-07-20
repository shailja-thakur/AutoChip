module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({a, b, c, d})
			4'h0: out = 1'b0;
			4'h1: out = 1'b0;
			4'h2: out = 1'b1;
			4'h3: out = 1'b1;
			4'h4: out = 1'bx;
			4'h5: out = 1'b0;
			4'h6: out = 1'b0;
			4'h7: out = 1'b0;
			4'h8: out = 1'b1;
			4'h9: out = 1'bx;
			4'hA: out = 1'b1;
			4'hB: out = 1'b1;
			4'hC: out = 1'b1;
			4'hD: out = 1'bx;
			4'hE: out = 1'b1;
			4'hF: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
endmodule
