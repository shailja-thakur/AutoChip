module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	reg state, q;
	always @(posedge clk)
	begin
		// combinational logic
		state <= a & b;
		q <= state ^ a;
	end
endmodule
