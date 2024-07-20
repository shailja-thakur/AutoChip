module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg prev_a;
reg prev_prev_a;

always @(posedge clock) begin
	prev_prev_a <= prev_a;
	prev_a <= a;
	if (a && !prev_a && prev_prev_a)
		p <= 1;
	else
		p <= 0;
	
	if (!a && prev_prev_a)
		q <= 1;
	else
		q <= 0;
end

endmodule
