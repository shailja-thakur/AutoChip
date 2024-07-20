module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg state;
reg next_state;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= B;
		next_state <= B;
	end else begin
		state <= next_state;
		if (state == B) begin
			if (in == 0)
				next_state <= A;
			else if (in == 1)
				next_state <= B;
		end else if (state == A) begin
			if (in == 0)
				next_state <= B;
			else if (in == 1)
				next_state <= A;
		end
	end
end

always @(state) begin
	if (state == B)
		out = 1;
	else if (state == A)
		out = 0;
end

endmodule
