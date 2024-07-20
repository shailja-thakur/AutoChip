module top_module (
	input clk,
	input a,
	output reg q
);
	reg state;

	always @(posedge clk) begin
		if (a == 1)
			state <= 1'b0;  // Reset the state when a is 1
		else
			state <= 1'b1;  // Set the state when a is 0
	end

	always @(posedge clk) begin
		q <= state;
	end
endmodule
