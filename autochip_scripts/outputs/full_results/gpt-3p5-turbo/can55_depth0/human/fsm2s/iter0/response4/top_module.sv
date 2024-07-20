module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define state enum
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;
	
	// Define state register and next state register
	reg state_t current_state;
	reg state_t next_state;
	
	// Define output register
	reg out;
	
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset) begin
			// Reset to state OFF
			current_state <= OFF;
		end else begin
			// Update current state with next state
			current_state <= next_state;
		end
	end
	
	always_comb
	begin
		// Default values
		next_state = current_state;
		out = (current_state == ON);
		
		// State transitions
		case (current_state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end
			end
			ON: begin
				if (!k) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
		endcase
	end

endmodule
