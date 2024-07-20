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
	// State transitions
	if (state == 0 && a == 0 && b == 0)
		state <= 0;
	else if (state == 0 && a == 0 && b == 1)
		state <= 1;
	else if (state == 0 && a == 1 && b == 0)
		state <= 1;
	else if (state == 0 && a == 1 && b == 1)
		state <= 1;
	else if (state == 1 && a == 0 && b == 0)
		state <= 1;
	else if (state == 1 && a == 0 && b == 1)
		state <= 1;
	else if (state == 1 && a == 1 && b == 0)
		state <= 1;
	else if (state == 1 && a == 1 && b == 1)
		state <= 1;
	
	// Output logic
	if (state == 0)
		q <= 0;
	else if (state == 1)
		q <= 1;
end

assign state = q;

endmodule
