module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	// Define the states using parameters
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	// Define the next state logic using a case statement
	always @* begin
		case ({y[3], y[2], y[1]})
			3'b000: if (w) Y2 = 0; else Y2 = 1;
			3'b001: if (w) Y2 = 1; else Y2 = 0;
			3'b010: if (w) Y2 = 0; else Y2 = 1;
			3'b011: if (w) Y2 = 1; else Y2 = 1;
			3'b100: if (w) Y2 = 1; else Y2 = 1;
			3'b101: if (w) Y2 = 0; else Y2 = 1;
			default: Y2 = 0;
		endcase
	end
endmodule
