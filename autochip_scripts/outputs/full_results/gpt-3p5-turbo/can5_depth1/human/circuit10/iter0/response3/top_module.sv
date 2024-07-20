module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg state;
reg q;

always @(posedge clk) begin
	state <= a & b;
	q <= state;
end

endmodule
