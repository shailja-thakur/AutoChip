module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	// Define the states
	typedef enum logic [2:0] {
		IDLE,		// Idle state
		ONE,		// State when seeing a single 1
		TWO,		// State when seeing two consecutive 1s
		THREE,		// State when seeing three consecutive 1s
		FOUR,		// State when seeing four consecutive 1s
		FIVE,		// State when seeing five consecutive 1s
		SIX,		// State when seeing six consecutive 1s
		SEVEN,		// State when seeing seven or more consecutive 1s
		FLAG		// State when seeing the flag pattern
	} state_t;
	
	// Define the state register
	reg state_t current_state, next_state;
	
	// Define the output register
	reg disc, flag, err;
	
	// Next state logic
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;		// Initialize the state to IDLE
		end else begin
			current_state <= next_state;	// Update the state
		end
	end
	
	// Output logic
	always@(current_state) begin
		// Reset the outputs
		disc <= 0;
		flag <= 0;
		err <= 0;
		
		case (current_state)
			IDLE: begin
				if (in == 1) begin
					next_state = ONE;	// Transition to ONE state
				end else begin
					next_state = IDLE;	// Stay in IDLE state
				end
			end
			
			ONE: begin
				if (in == 1) begin
					next_state = TWO;	// Transition to TWO state
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			TWO: begin
				if (in == 1) begin
					next_state = THREE;	// Transition to THREE state
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			THREE: begin
				if (in == 1) begin
					next_state = FOUR;	// Transition to FOUR state
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			FOUR: begin
				if (in == 1) begin
					next_state = FIVE;	// Transition to FIVE state
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			FIVE: begin
				if (in == 1) begin
					next_state = SIX;	// Transition to SIX state
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			SIX: begin
				if (in == 1) begin
					next_state = SEVEN;	// Transition to SEVEN state
				end else begin
					next_state = FLAG;	// Transition to FLAG state
				end
			end
			
			SEVEN: begin
				if (in == 1) begin
					next_state = SEVEN;	// Stay in SEVEN state
					err = 1;		// Indicate an error
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
				end
			end
			
			FLAG: begin
				if (in == 1) begin
					next_state = SEVEN;	// Transition to SEVEN state
					disc = 1;		// Indicate a bit needs to be discarded
				end else begin
					next_state = IDLE;	// Transition back to IDLE state
					flag = 1;		// Indicate a flag is detected
				end
			end
		endcase
	end
endmodule
