module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q, state; // declare flip-flop outputs as registers

always @(posedge clk) begin
	state <= a & b; // combinational logic
	q <= state; // output of flip-flop
end

endmodule
