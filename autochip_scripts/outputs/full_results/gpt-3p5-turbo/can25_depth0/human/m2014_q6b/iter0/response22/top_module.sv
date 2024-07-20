module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*)
		begin
			// Next-state logic for y[2]
			case(y)
				3'b000:
					Y2 = w; // For state A
				3'b001:
					Y2 = w; // For state B
				3'b010:
					Y2 = 1; // For state C
				3'b011:
					Y2 = w; // For state D
				3'b100:
					Y2 = w; // For state E
				3'b101:
					Y2 = 0; // For state F
				default:
					Y2 = 0;
			endcase
		end

endmodule
