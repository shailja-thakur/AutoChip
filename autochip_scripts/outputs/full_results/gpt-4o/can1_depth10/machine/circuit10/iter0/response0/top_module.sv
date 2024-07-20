module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg c;

// Update c at every rising edge of clk
always @(posedge clk) begin
	c <= (a & b) | (a & c) | (b & c);
end

// Calculate the outputs q and state
always @(*) begin
	q = a ^ b ^ c;
	state = c;
end

endmodule
