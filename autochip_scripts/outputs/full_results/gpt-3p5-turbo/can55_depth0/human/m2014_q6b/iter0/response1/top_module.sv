module top_module(
	input [3:1] y,
	input w,
	output reg Y2
);

	// Define state codes
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	// Next-state logic
	always @(*) begin
		case (y)
			A: if (w) Y2 = 0; else Y2 = 0;
			B: if (w) Y2 = 1; else Y2 = 1;
			C: if (w) Y2 = 1; else Y2 = 1;
			D: if (w) Y2 = 0; else Y2 = 0;
			E: if (w) Y2 = 0; else Y2 = 1;
			F: if (w) Y2 = 1; else Y2 = 0;
			default: Y2 = 0;
		endcase
	end

endmodule
