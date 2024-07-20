module top_module(
	input [3:0] p1a, 
	input [3:0] p1b, 
	input [3:0] p1c, 
	input [3:0] p1d, 
	output reg p1y, 
	input [3:0] p2a, 
	input [3:0] p2b, 
	input [3:0] p2c, 
	input [3:0] p2d, 
	output reg p2y
);

	always @(*) begin
		if ((~p1a & ~p1b & ~p1c & ~p1d) | (~p2a & ~p2b & ~p2c & ~p2d))
			p1y = 1'b0;
		else
			p1y = 1'b1;

		if (((~p1a & ~p1b & ~p1c & ~p1d) | (~p2a & ~p2b & ~p2c & ~p2d)) & ((~p1a | ~p1b | ~p1c | ~p1d) | (~p2a | ~p2b | ~p2c | ~p2d))) 
			p2y = 1'b0;
		else
			p2y = 1'b1;
	end

endmodule
