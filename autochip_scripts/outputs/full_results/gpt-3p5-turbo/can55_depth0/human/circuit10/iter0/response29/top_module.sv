module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

// D flip-flop
always @(posedge clk) begin
    q <= a & b;
    state <= q;
end

endmodule
