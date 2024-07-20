module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = w ? 1'b0 : 1'b0; // A
			3'b001: Y2 = w ? 1'b1 : 1'b0; // B
			3'b010: Y2 = w ? 1'b1 : 1'b1; // C
			3'b011: Y2 = w ? 1'b0 : 1'b1; // D
			3'b100: Y2 = 1'b1;            // E (w does not matter)
			3'b101: Y2 = 1'b0;            // F (w does not matter)
			default: Y2 = 1'b0;           // default case to avoid latches
		endcase
	end

endmodule
