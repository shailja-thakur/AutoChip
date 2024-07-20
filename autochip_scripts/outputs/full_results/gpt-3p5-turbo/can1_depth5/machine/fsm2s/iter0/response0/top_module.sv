module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	if (state == A && j)
		next_state = B;
	else if (state == B && k)
		next_state = A;
	else
		next_state = state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
