module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, nextState;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 0;
	else
		state <= nextState;
end

always @(state, in)
begin
	case (state)
		0: begin
			if (in)
				nextState = 0;
			else
				nextState = 1;
		end

		1: begin
			if (in)
				nextState = 1;
			else
				nextState = 0;
		end

		default: nextState = 0;
	endcase
end

assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
