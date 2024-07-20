module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 1'b0;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		0: begin
			if (in)
				next_state <= 0;
			else
				next_state <= 1;
		end
		1: begin
			if (in)
				next_state <= 1;
			else
				next_state <= 0;
		end
	endcase
end

assign out = state;

endmodule
