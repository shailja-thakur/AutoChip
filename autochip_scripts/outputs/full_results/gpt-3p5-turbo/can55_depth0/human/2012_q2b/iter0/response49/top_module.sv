module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1_reg, Y3_reg;

always @(w or y) begin
	case(y)
		6'b000001: Y1_reg = w;
		6'b000010: Y1_reg = Y1_reg;
		6'b000100: Y1_reg = w;
		6'b001000: Y1_reg = Y1_reg;
		6'b001000: Y1_reg = Y1_reg;
		6'b010000: Y1_reg = Y3_reg;
		6'b100000: Y1_reg = Y3_reg;
	endcase

	Y3_reg = Y1_reg;

end

assign Y1 = Y1_reg;
assign Y3 = Y3_reg;

endmodule
