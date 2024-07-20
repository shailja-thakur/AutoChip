module top_module (
  input clk,
  input in,
  input areset,
  output out
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// Define the state and next_state variables
reg state, next_state;

// Define the output variable
reg out;

// Define the state transition logic
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

// Define the output logic
always @(state, in) begin
	case (state)
		A: begin
			out <= 1'b0;
			if (in)
				next_state <= A;
			else
				next_state <= B;
		end
		B: begin
			out <= 1'b1;
			if (in)
				next_state <= B;
			else
				next_state <= A;
		end
	endcase
end

endmodule
