module top_module(
	input [3:0] y,
	input w,
	output reg Y2);

	always_comb begin
		case({y, w})
			4'b0000, 4'b0001, 4'b0110, 4'b0111: Y2 = 0;
			4'b0010, 4'b0011, 4'b0101, 4'b1000: Y2 = 1;
			default: Y2 = 1;
		endcase
	end

endmodule
