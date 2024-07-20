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
    state <= (b ^ state) & a;
    q <= state;
end

endmodule
