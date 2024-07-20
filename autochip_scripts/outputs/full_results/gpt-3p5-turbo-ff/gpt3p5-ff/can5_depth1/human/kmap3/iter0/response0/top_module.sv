module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*)
	begin
		// Implement the logic based on the Karnaugh map
		case ({a, b, c, d})
			4'b00??:
				out = 1;
			4'b0?0?:
				out = 0;
			4'b0??1:
				out = d;
			4'b01?1:
				out = d;
			4'b11??:
				out = 1;
			4'b1??1:
				out = 1;
			default:
				out = 0;
		endcase
	end

endmodule
