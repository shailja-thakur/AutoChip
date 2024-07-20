module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	reg [2:0] state, next_state;
	reg disc_out, flag_out, err_out;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initial state: no consecutive 1s
		else
			state <= next_state;
	end
	
	always @(state or in) begin
		// Default next state
		next_state = state;
		
		// Default outputs
		disc_out = 0;
		flag_out = 0;
		err_out = 0;
		
		case (state)
			// No consecutive ones
			3'b000: begin
				if (in)
					next_state = 3'b001; // Start checking for consecutive ones
			end
			
			// Counting consecutive ones
			3'b001: begin
				if (in)
					next_state = 3'b010; // Continue counting
				else
					next_state = 3'b000; // Reset count
			end
			
			// Discarding the next bit
			3'b010: begin
				if (in)
					next_state = 3'b011; // Check for consecutive ones
				else
					next_state = 3'b000; // Reset count
				
				disc_out = 1; // Set disc signal for a complete cycle
			end
			
			// Checking for consecutive ones
			3'b011: begin
				if (in)
					next_state = 3'b100; // Flag or error
				else
					next_state = 3'b000; // Reset count
			end
			
			// 01111110 - Flag
			3'b100: begin
				if (in)
					next_state = 3'b100; // Continue flag state
				else
					next_state = 3'b101; // Flag complete
				
				flag_out = 1; // Set flag signal for a complete cycle
			end
			
			// Flag complete
			3'b101: begin
				next_state = 3'b000; // Reset count
			end
			
			// Error (7 or more consecutive ones)
			3'b110: begin
				next_state = 3'b000; // Reset count
				
				err_out = 1; // Set err signal for a complete cycle
			end
			
			default: begin
				// Should not happen unless there is an error in the state machine
				next_state = 3'b000; // Reset count
			end
		endcase
	end
	
	assign disc = disc_out;
	assign flag = flag_out;
	assign err = err_out;
endmodule
