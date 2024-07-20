module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	// Declare state and next state variables
	state_type state, next_state;
	
	// Declare output register
	reg out_reg;

	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			out_reg <= 0;
		end else begin
			state <= next_state;
			out_reg <= (state == D) ? 1 : 0;
		end
	end
	
	// Next state logic
	always @(*) begin
		next_state = state; // Default next state is current state
		
		// Determine next state based on current state and input
		case (state)
			A: begin
				if (in) next_state = B;
				else next_state = A;
			end
			B: begin
				if (in) next_state = B;
				else next_state = C;
			end
			C: begin
				if (in) next_state = D;
				else next_state = A;
			end
			D: begin
				if (in) next_state = B;
				else next_state = C;
			end
		endcase
	end
	
	// Assign output
	assign out = out_reg;
	
endmodule
