module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 2'b00;	// Define states as parameters
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	reg next_state;	// Define next state variable
	reg state;		// Define current state variable

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S;	// Reset state to S
		else
			state <= next_state;	// Assign next state to current state
	end

	always @(state or x) begin
		case (state)
			S: begin		// State S
				if (x)		// If x is 1
					next_state = S1;	// Next state S1
				else
					next_state = S;		// Next state S
				z = 0;		// Output z is 0
			end
			S1: begin	// State S1
				if (x)		// If x is 1
					next_state = S1;	// Next state S1
				else
					next_state = S10;	// Next state S10
				z = 0;		// Output z is 0
			end
			S10: begin	// State S10
				if (x)		// If x is 1
					next_state = S1;	// Next state S1
				else
					next_state = S;		// Next state S
				z = x;		// Output z is input x
			end
		endcase
	end

endmodule
