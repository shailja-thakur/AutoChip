module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;

reg state;
always @(posedge clk) begin
	if (reset)
		state <= B;
	else
		state <= (state == A && in) ? A :
				  (state == B && in) ? B :
				  (state == A && !in) ? B :
				  (state == B && !in) ? A :
				  state;
end

assign out = (state == B) ? 1 : 0;

endmodule
