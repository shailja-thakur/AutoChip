module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg state;
reg next_state;

initial begin
	state = A;
	out = 0;
end

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state, j, k) begin
	case(state)
		A: begin
			if (j)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (k)
				next_state = A;
			else
				next_state = B;
		end
	endcase
end

always @(state) begin
	if (state == B)
		out = 1;
	else
		out = 0;
end

endmodule
