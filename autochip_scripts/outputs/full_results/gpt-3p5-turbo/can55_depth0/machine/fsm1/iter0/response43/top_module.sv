module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		0: begin
			if (in)
				next_state = 0;
			else
				next_state = 1;
		end
		1: begin
			if (in)
				next_state = 1;
			else
				next_state = 0;
		end
	endcase
end

assign out = state;

endmodule
