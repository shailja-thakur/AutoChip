module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg next_p;
reg next_q;

always @(posedge clock) begin
	if (a && p && !q)
		next_p <= 1;
	else
		next_p <= 0;
	
	if (a && q)
		next_q <= 1;
	else
		next_q <= 0;
end

always @(posedge clock) begin
	p <= next_p;
	q <= next_q;
end

endmodule
