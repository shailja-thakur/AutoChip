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
		state <= a & b;
		q <= state;
	end
endmodule
