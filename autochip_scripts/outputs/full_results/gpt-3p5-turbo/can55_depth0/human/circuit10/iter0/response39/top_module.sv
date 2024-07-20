module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q; // flip flop output
reg state; // state variable

always @(posedge clk) begin
	state <= a & b;
	q <= state;
end

endmodule
