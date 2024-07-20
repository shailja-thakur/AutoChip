module top_module (
	input clk,
	input a, 
	output reg q
);

	reg q_prev;

	always @(posedge clk) begin
		q_prev <= q;
		if (a == 1 && q_prev == 0)
			q <= 1;
		else if (a == 0 && q_prev == 1)
			q <= 0;
	end
	
endmodule
