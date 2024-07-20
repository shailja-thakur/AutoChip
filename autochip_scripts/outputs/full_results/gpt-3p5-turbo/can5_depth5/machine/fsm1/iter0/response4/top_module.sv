module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 1'b0;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		0: begin // State A
			if (in) begin
				next_state = 1'b0; // Stay in State A
			end else begin
				next_state = 1'b1; // Transition to State B
			end
		end
		1: begin // State B
			if (in) begin
				next_state = 1'b1; // Stay in State B
			end else begin
				next_state = 1'b0; // Transition to State A
			end
		end
	endcase
end

assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
