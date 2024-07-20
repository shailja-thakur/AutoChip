module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg Y1;
	reg Y3;

	always @(*) begin
		case(y)
			6'b000001, 6'b000010, 6'b001000, 6'b100000: Y1 = 1'b0;
			default: Y1 = 1'b1;
		endcase
	end

	always @(*) begin
		case(y)
			6'b000100, 6'b010000: Y3 = 1'b0;
			default: Y3 = 1'b1;
		endcase
	end

endmodule
