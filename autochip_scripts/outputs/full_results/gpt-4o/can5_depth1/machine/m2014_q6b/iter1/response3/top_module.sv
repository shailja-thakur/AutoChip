module top_module(
	input [3:0] y,
	input w,
	output reg Y2);

always_comb begin
    case ({y, w})
        5'h10: Y2 = 1'b0; // 4'h0, w=0
        5'h11: Y2 = 1'b0; // 4'h0, w=1
        5'h12: Y2 = 1'b0; // 4'h1, w=0
        5'h13: Y2 = 1'b0; // 4'h1, w=1
        5'h14: Y2 = 1'b0; // 4'h2, w=0
        5'h15: Y2 = 1'b1; // 4'h2, w=1
        5'h16: Y2 = 1'b0; // 4'h3, w=0
        5'h17: Y2 = 1'b1; // 4'h3, w=1
        5'h18: Y2 = 1'b0; // 4'h4, w=0
        5'h19: Y2 = 1'b0; // 4'h4, w=1
        5'h1A: Y2 = 1'b0; // 4'h5, w=0
        5'h1B: Y2 = 1'b1; // 4'h5, w=1
        5'h1C: Y2 = 1'b0; // 4'h6, w=0
        5'h1D: Y2 = 1'b0; // 4'h6, w=1
        5'h1E: Y2 = 1'b0; // 4'h7, w=0
        5'h1F: Y2 = 1'b0; // 4'h7, w=1
        5'h20: Y2 = 1'b0; // 4'h8, w=0
        5'h21: Y2 = 1'b0; // 4'h8, w=1
        5'h22: Y2 = 1'b0; // 4'h9, w=0
        5'h23: Y2 = 1'b1; // 4'h9, w=1
        5'h24: Y2 = 1'b0; // 4'hA, w=0
        5'h25: Y2 = 1'b1; // 4'hA, w=1
        5'h26: Y2 = 1'b0; // 4'hB, w=0
        5'h27: Y2 = 1'b1; // 4'hB, w=1
        default: Y2 = 1'b0;
    endcase
end

endmodule
