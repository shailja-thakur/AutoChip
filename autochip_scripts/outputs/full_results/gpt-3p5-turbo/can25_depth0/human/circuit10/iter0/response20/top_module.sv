module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
	if (a == 0 && b == 0)
		q <= 0;
	else if (a == 0 && b == 1)
		q <= 1;
	else if (a == 1 && b == 0)
		q <= state;
	else if (a == 1 && b == 1)
		q <= !state;
	
	state <= q;
end

assign state = q;

endmodule
