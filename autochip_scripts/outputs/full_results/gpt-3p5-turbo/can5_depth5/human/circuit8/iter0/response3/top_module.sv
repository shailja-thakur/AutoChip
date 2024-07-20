module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg a_delay1;
reg a_delay2;

always @(posedge clock) begin
	a_delay1 <= a;
	a_delay2 <= a_delay1;
end

always @(posedge clock) begin
	if (a_delay2 == 1'd0)
		p <= 1'd0;
	else if (p == 1'd1 && a_delay2 == 1'd1)
		p <= 1'd1;
end

always @(posedge clock) begin
	if (p == 1'd1)
		q <= 1'd0;
	else if (q == 1'd1 && p == 1'd0)
		q <= 1'd1;
end

endmodule
