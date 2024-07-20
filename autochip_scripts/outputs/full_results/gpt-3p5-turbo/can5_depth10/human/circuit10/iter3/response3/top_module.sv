module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg q_temp;

always @(posedge clk) begin
	if (a & ~b)
		state <= 1'b1;
	else
		state <= 1'b0;

	q_temp <= state;
end

always @(posedge clk) begin
	q <= q_temp;
end

endmodule
