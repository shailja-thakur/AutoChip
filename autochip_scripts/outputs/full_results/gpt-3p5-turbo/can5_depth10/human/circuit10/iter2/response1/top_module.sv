module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg next_state;

always @(posedge clk) begin
	next_state <= (a & ~b) | (state & (a | b));
end

always @(posedge clk) begin
	state <= next_state;
	q <= state;
end

endmodule
