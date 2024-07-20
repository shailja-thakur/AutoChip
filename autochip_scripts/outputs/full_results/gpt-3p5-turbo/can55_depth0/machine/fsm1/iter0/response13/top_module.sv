module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state;
wire next_state;

// State machine behavior
always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

// Determine next state based on current state and input
always @(state or in) begin
	case (state)
		1'b0: begin
			if (in)
				next_state = 1'b0;
			else
				next_state = 1'b1;
		end
		
		1'b1: begin
			if (in)
				next_state = 1'b1;
			else
				next_state = 1'b0;
		end
	endcase
end

// Output assignment
assign out = ~state;

endmodule
