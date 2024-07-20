module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @* begin
		case(y)
			3'b000: Y2 = w;    // A
			3'b001: Y2 = 1;    // B
			3'b010: Y2 = y[2]; // C
			3'b011: Y2 = 1;    // D
			3'b100: Y2 = 1;    // E
			3'b101: Y2 = y[2]; // F
			default: Y2 = 0;
		endcase
	end

endmodule
