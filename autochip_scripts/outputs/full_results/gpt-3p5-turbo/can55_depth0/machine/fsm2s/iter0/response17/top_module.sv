module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg state;
reg next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	if (state == A) begin
		if (j)
			next_state = B;
		else
			next_state = A;
	end
	else begin
		if (k)
			next_state = A;
		else
			next_state = B;
	end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
