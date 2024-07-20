module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	parameter OFF = 0;
	parameter ON = 1;
	
	// Define the current state variable
	reg [1:0] current_state;
	
	// Define the next state variable
	reg [1:0] next_state;
	
	// Define the output variable
	reg out;
	
	// Always block to synchronize with the clock
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state machine to OFF state
			current_state <= OFF;
		end else begin
			// Update next state based on current state and inputs
			case (current_state)
				OFF: begin
					if (j) begin
						next_state <= ON;
					end else begin
						next_state <= OFF;
					end
				end
				ON: begin
					if (k) begin
						next_state <= OFF;
					end else begin
						next_state <= ON;
					end
				end
				default: next_state <= OFF;
			endcase
			// Update current state
			current_state <= next_state;
		end
	end
	
	// Assign the output based on the current state
	always @(current_state) begin
		case (current_state)
			OFF: out <= 0;
			ON: out <= 1;
			default: out <= 0;
		endcase
	end
endmodule
