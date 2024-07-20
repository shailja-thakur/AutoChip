module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states using an enumerated type
	typedef enum logic [1:0] {B, A} state_type;
	
	// Declare state and next_state variables
	reg state_type state, next_state;
	
	// Declare output variable
	reg out;
	
	// Define state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	// Define next_state logic
	always @(state or in) begin
		case(state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = B; // Default case for invalid state
		endcase
	end
	
	// Define output logic
	always @(state) begin
		case(state)
			B: out = 1;
			A: out = 0;
		endcase
	end
	
endmodule
