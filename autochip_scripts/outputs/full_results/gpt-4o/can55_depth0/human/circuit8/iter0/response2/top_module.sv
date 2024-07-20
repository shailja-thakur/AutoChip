module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg prev_a;

	always @(posedge clock or negedge clock) begin
		if (!clock) begin
			q <= (a || q);
			if (a == 1'b1)
			    p <= 1'b1;
			else
			    p <= 1'b0;
		end else begin
			q <= (a || q);
		    prev_a <= a;
		end
	end
endmodule
