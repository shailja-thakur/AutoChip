module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define states A and B
parameter A = 1'b0;
parameter B = 1'b1;

// Define the state and next_state variables
reg state, next_state;

always @(posedge clk or areset) begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

always @(state or in) begin
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
	endcase
end

assign out = state;

endmodule
