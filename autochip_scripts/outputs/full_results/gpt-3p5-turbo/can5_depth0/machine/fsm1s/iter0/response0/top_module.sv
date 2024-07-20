module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;
reg state;

always @(posedge clk) begin
	if (reset)
		state <= B;
	else if (state == A)
		state <= (in) ? A : B;
	else if (state == B)
		state <= (in) ? B : A;
end

assign out = state;

endmodule
