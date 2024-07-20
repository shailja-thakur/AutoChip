module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Define the state and state_nexxt signals
	reg [1:0] state, state_next;
	
	// Define the next state logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;  // Initial state
		end else begin
			state <= state_next;  // Update state
		end
	end
	
	// Define the next state logic
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					state_next = S;  // Stay in S state
				end else begin
					state_next = S1;  // Transition to S1 state
				end
			end
			
			S1: begin
				if (x == 1'b0) begin
					state_next = S10;  // Transition to S10 state
				end else begin
					state_next = S1;  // Stay in S1 state
				end
			end
			
			S10: begin
				if (x == 1'b0) begin
					state_next = S;  // Transition to S state
				end else begin
					state_next = S1;  // Transition to S1 state
				end
			end
			
			default: begin
				state_next = S;  // Default to S state
			end
		endcase
	end
	
	// Define the output logic
	always @(state or x) begin
		case (state)
			S, S1, S10: begin
				z = 1'b0;
			end
			
			default: begin
				z = x;  // Output is the input x when in S10 state
			end
		endcase
	end
	
endmodule
