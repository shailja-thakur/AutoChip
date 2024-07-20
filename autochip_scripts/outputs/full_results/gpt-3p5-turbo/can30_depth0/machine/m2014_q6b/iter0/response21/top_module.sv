module top_module(
	input [3:0] y,
	input w,
	output reg Y2
);

always_comb begin
	case({y, w})
		4'h0, 4'h1: Y2 = 0;
		4'h2, 4'h3: Y2 = 1;
		4'h4: Y2 = 0;
		4'h5, 4'h9, 4'ha, 4'hb: Y2 = 1;
		default: Y2 = 0;
	endcase
end

endmodule
