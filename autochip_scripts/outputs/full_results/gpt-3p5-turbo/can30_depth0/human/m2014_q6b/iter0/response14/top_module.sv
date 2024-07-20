module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	// Declare the flip-flops for storing the current state
	reg [3:1] current_state;
	
	// Declare the next-state logic for y[2]
	always @(*)
	begin
		case (y)
			3'd1: if (w) Y2 = 0; else Y2 = 0;
			3'd2: if (w) Y2 = 0; else Y2 = 1;
			3'd3: if (w) Y2 = 1; else Y2 = 0;
			3'd4: if (w) Y2 = 1; else Y2 = 1;
			3'd5: if (w) Y2 = 1; else Y2 = 0;
			3'd6: if (w) Y2 = 1; else Y2 = 1;
			default: Y2 = 0;
		endcase
	end

endmodule
