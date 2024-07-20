module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	if (a & b)
		q <= q;
	else
		q <= ~q;
	state <= q[0] ^ q[1];
end

endmodule
