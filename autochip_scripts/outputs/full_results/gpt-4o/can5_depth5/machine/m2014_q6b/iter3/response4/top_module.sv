module top_module(
	input [2:0] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'h0: Y2 = 0;
			3'h1: Y2 = 0;
			3'h2: Y2 = 1;
			3'h3: Y2 = 1;
			3'h4: Y2 = 0;
			3'h5: Y2 = 1;
			3'h6: Y2 = 0;
			3'h7: Y2 = 0;
			default: Y2 = 0;
		endcase
	end

endmodule
