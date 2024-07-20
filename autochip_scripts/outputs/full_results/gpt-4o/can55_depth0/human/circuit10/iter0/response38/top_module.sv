module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);
	
	always @(posedge clk) begin
		if (a && b) begin
			// If both a and b are 1, toggle the state and q
			state <= ~state;
			q <= state;
		end else if (a && !b) begin
			// If a is 1 and b is 0, set state and q to 0
			state <= 0;
			q <= 0;
		end else if (!a && b) begin
			// If a is 0 and b is 1, set state and q to 1
			state <= 1;
			q <= 1;
		end else begin
			// If a and b are both 0, maintain the state and q
			state <= state;
			q <= q;
		end
	end

endmodule
