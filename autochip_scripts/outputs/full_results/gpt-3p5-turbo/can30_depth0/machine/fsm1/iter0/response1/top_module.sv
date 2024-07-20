module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 1'b0;
	else
		state <= next_state;
end

always @(*)
begin
	case(state)
		0: begin // State A
			if (in)
				next_state = 1'b0; // Stay in state A
			else
				next_state = 1'b1; // Transition to state B
		end
		1: begin // State B
			if (in)
				next_state = 1'b1; // Stay in state B
			else
				next_state = 1'b0; // Transition to state A
		end
	endcase
end

assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
