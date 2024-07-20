module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg state;

	always @(posedge clk) begin
		if (state)
			q <= a & b;
		else
			q <= 1'b0;
	end

	always @(posedge clk) begin
		if (state)
			state <= a | ~b;
		else if (a == 1'b1)
			state <= 1'b1;
		else
			state <= 1'b0;
	end

endmodule
