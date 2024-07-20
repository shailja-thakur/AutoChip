module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*)
	begin
		// Next-state logic for Y2 (y[2])
		case(y)
			3'd1: Y2 = 1;
			3'd2: Y2 = 0;
			3'd3: Y2 = w;
			3'd4: Y2 = w;
			3'd5: Y2 = w;
			3'd6: Y2 = w;
			default: Y2 = 0;
		endcase
	end
	
endmodule
