module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg q_prev;
initial q_prev = 1'b0;

always @(posedge clk) begin
	state <= a & b;
	q <= q_prev;
	q_prev <= ~state;
end

endmodule
