module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

always @(state, in) begin
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
	end
end

always @(posedge clk) begin
	if (areset)
		out <= 1'b0;
	else if (state == 1)
		out <= 1'b1;
	else
		out <= 1'b0;
end

endmodule
