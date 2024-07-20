module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		casez (y)
			3'b000: Y2 = 1'b0; // A -> B
			3'b001: Y2 = 1'b1; // B -> A
			3'b010: Y2 = 1'b1; // C -> D
			3'b011: Y2 = (w == 1'b0) ? 1'b1 : 1'b0; // D -> A or D -> F
			3'b100: Y2 = 1'b0; // E -> D
			3'b101: Y2 = 1'b1; // F -> D
			default: Y2 = 1'b0; // Default
		endcase
	end

endmodule
