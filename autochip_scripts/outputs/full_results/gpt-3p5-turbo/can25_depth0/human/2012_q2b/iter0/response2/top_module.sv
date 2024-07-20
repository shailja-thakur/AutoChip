module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1_reg;
reg Y3_reg;

always @(posedge w) begin
	case(y)
		6'b000001: // A
			Y1_reg <= 0;
			Y3_reg <= 0;
		6'b000010: // B
			Y1_reg <= 0;
			Y3_reg <= 0;
		6'b000100: // C
			Y1_reg <= 0;
			Y3_reg <= 0;
		6'b001000: // D
			Y1_reg <= 1;
			Y3_reg <= 0;
		6'b010000: // E
			Y1_reg <= 1;
			Y3_reg <= 0;
		6'b100000: // F
			Y1_reg <= 1;
			Y3_reg <= 1;
	endcase
end

assign Y1 = Y1_reg;
assign Y3 = Y3_reg;

endmodule
