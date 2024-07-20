module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg q_prev;
reg state_prev;
initial begin
	q_prev = 1'b0;
	state_prev = 1'b0;
end

always @(posedge clk) begin
	state_prev <= a & b;
	q_prev <= ~q_prev;
end

always @(posedge clk) begin
	state <= state_prev;
	q <= q_prev;
end

endmodule
