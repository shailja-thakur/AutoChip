module top_module(
	input [7:0] p1,
	output reg p1y,
	input [7:0] p2,
	output reg p2y
);

	always @(*)
	begin
		p1y = ~(p1[0] & p1[1] & p1[2] & p1[3]);
		p2y = ~(p2[4] & p2[5] & p2[6] & p2[7]);
	end
	
endmodule
