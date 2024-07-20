module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states using an enum
	typedef enum logic [1:0] {S, S1, S10} state_type;
	
	// Create state and state_next variables
	reg state, state_next;
	
	// Define the state transition function
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S; // Initial state
		end
		else begin
			state <= state_next; // Update state based on next state
		end
	end
	
	// Define the state next logic
	always_comb begin
		case (state)
			S: begin
				if (x == 1) begin
					state_next = S1;
				end
				else begin
					state_next = S;
				end
			end
			
			S1: begin
				if (x == 0) begin
					state_next = S10;
				end
				else begin
					state_next = S1;
				end
			end
			
			S10: begin
				if (x == 1) begin
					state_next = S1;
				end
				else begin
					state_next = S;
				end
			end
			
			default: begin
				state_next = S;
			end
		endcase
	end
	
	// Define the output logic
	always_comb begin
		case (state)
			S, S1: begin
				z = 0;
			end
			
			S10: begin
				z = x;
			end
			
			default: begin
				z = 0;
			end
		endcase
	end
	
endmodule
