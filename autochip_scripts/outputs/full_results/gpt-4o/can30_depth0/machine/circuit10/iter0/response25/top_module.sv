module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg c;

// Calculate c at each rising edge of the clock
always @(posedge clk) begin
	c <= (a & b) | (a & c) | (b & c);
end

// Calculate outputs q and state
always @(*) begin
	q = a ^ b ^ c;
	state = c;
end

endmodule
