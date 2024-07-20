module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

// State register
always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

// Next state logic
always @(state, in) begin
	case (state)
		0: begin // State A
			if (in)
				next_state = 0;
			else
				next_state = 1;
		end

		1: begin // State B
			if (in)
				next_state = 1;
			else
				next_state = 0;
		end
		
		default: next_state = 1; // Default value
	endcase
end

// Output logic
assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
