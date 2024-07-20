module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		B: begin
			if (in == 0)
				next_state = A;
			else
				next_state = B;
		end
		A: begin
			if (in == 0)
				next_state = B;
			else
				next_state = A;
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
