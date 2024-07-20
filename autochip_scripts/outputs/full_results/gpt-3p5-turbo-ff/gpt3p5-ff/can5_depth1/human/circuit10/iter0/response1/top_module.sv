module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg q_next;

	always @(posedge clk) begin
		if (state)
			q <= a;
		else
			q <= q_next;
	end

	always @(a, b, q) begin
		if (state)
			q_next <= b;
		else if (a && !b)
			q_next <= 1'b0;
		else if (!a && b)
			q_next <= 1'b1;
		else
			q_next <= q;
	end

	always @(posedge clk) begin
		if (a && b)
			state <= 1'b1;
		else if (a || b)
			state <= 1'b0;
		else
			state <= state;
	end

endmodule
