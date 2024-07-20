module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define states
parameter A = 1'b0;
parameter B = 1'b1;

reg state, next_state;

// State transition logic
always @(*) begin
	case (state)
		A: begin
			if (in)
				next_state = A;
			else
				next_state = B;
		end
		B: begin
			if (in)
				next_state = B;
			else
				next_state = A;
		end
		default: next_state = B;
	endcase
end

// State update
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= B; // Reset state
	else
		state <= next_state;
end

// Output logic
assign out = (state == B);

endmodule
