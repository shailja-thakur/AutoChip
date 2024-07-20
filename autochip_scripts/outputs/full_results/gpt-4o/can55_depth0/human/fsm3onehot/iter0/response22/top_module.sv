module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

	// State transition logic
	always @(*) begin
		case (state)
			4'b0001: begin // State A
				if (in) 
					next_state = 4'b0010; // Go to State B
				else 
					next_state = 4'b0001; // Stay in State A
			end
			4'b0010: begin // State B
				if (in)
					next_state = 4'b0010; // Stay in State B
				else
					next_state = 4'b0100; // Go to State C
			end
			4'b0100: begin // State C
				if (in)
					next_state = 4'b1000; // Go to State D
				else
					next_state = 4'b0001; // Go to State A
			end
			4'b1000: begin // State D
				if (in)
					next_state = 4'b0010; // Go to State B
				else
					next_state = 4'b0100; // Go to State C
			end
			default: next_state = 4'b0001; // Default state is A
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (state)
			4'b0001: out = 1'b0; // Output for state A
			4'b0010: out = 1'b0; // Output for state B
			4'b0100: out = 1'b0; // Output for state C
			4'b1000: out = 1'b1; // Output for state D
			default: out = 1'b0; // Default output
		endcase
	end
	
endmodule
