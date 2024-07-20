module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	// Define states
	parameter A = 3'd0;
	parameter B = 3'd1;
	parameter C = 3'd2;
	parameter D = 3'd3;
	parameter E = 3'd4;
	parameter F = 3'd5;

	// Define next state logic
	always @* begin
		case(y)
			A: Y2 = w ? 0 : 1; // Next state depends on w
			B: Y2 = w ? 1 : 0; // Next state depends on w
			C: Y2 = w ? 0 : 1; // Next state depends on w
			D: Y2 = 1; // Next state is always 1
			E: Y2 = w ? 1 : 0; // Next state depends on w
			F: Y2 = w ? 0 : 1; // Next state depends on w
		endcase
	end
endmodule
