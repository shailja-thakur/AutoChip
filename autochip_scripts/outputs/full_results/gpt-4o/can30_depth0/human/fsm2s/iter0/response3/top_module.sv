module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;
	
	// State transition and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF; // Synchronous reset to OFF state
		end else begin
			state <= next_state; // State update
		end
	end

	always @(*) begin
		case (state)
			OFF: begin
				out = 0;
				if (j) 
					next_state = ON;
				else 
					next_state = OFF;
			end
			
			ON: begin
				out = 1;
				if (k) 
					next_state = OFF;
				else 
					next_state = ON;
			end
			
			default: begin
				next_state = OFF;
				out = 0;
			end
		endcase
	end
	
endmodule
