module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	if (a && b)
		q <= 0;
	else
		q <= (a | b);

	state <= q;
end

endmodule
