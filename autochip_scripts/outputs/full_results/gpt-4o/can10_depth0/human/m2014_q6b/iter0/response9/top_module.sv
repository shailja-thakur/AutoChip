module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	// State encoding
	localparam A = 3'b000,
			   B = 3'b001,
			   C = 3'b010,
			   D = 3'b011,
			   E = 3'b100,
			   F = 3'b101;

	always @(*) begin
		case (y)
			A: Y2 = 1'b0;  // A --0--> B, A --1--> A   (000)
			B: Y2 = w ? 1'b1 : 1'b0;  // B --0--> C, B --1--> D  (001)
			C: Y2 = w ? 1'b1 : 1'b0;  // C --0--> E, C --1--> D  (010)
			D: Y2 = 1'b1;  // D --0--> F, D --1--> A   (011)
			E: Y2 = 1'b0;  // E --0--> E, E --1--> D   (100)
			F: Y2 = 1'b0;  // F --0--> C, F --1--> D   (101)
			default: Y2 = 1'b0;
		endcase
	end
endmodule
