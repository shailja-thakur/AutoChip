module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	
	always@(posedge clock) begin
		if (a == 1'b1)
			p <= p + 1'b1;
		if (p == 1'b1)
			q <= q + 1'b1;
		end
	
endmodule
