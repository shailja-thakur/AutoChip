module top_module(
	input [3:0] y,
	input w,
	output reg Y2);

	always @*
	begin
		case({y, w})
			8'b0000_0000: Y2 = 1'b0;
			8'b0000_0001: Y2 = 1'b0;
			8'b0000_0010: Y2 = 1'b1;
			8'b0000_0011: Y2 = 1'b1;
			8'b0000_0100: Y2 = 1'b0;
			8'b0000_0101: Y2 = 1'b1;
			8'b0000_0110: Y2 = 1'b0;
			8'b0000_0111: Y2 = 1'b0;
			8'b0000_1000: Y2 = 1'b0;
			8'b0000_1001: Y2 = 1'b1;
			8'b0000_1010: Y2 = 1'b1;
			8'b0000_1011: Y2 = 1'b1;
			default: Y2 = 1'b0;
		endcase
	end

endmodule
