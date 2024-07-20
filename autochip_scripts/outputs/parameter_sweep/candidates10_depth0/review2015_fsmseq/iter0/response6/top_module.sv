module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Declare state types
	typedef enum logic [2:0] {
		IDLE,
		BEGIN,
		SEARCH,
		SHIFT
	} state_t;
	
	// Declare state register and next state logic
	reg state_t current_state, next_state;
	
	// Declare other intermediate signals
	reg [3:0] shift_reg;
	
	// Declare output signals
	reg start_shifting;
	
	// Synchronous state machine
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end
	
	// Combinational logic to determine next state and outputs
	always_comb begin
		next_state = current_state;
		start_shifting = 0;
		
		case (current_state)
			IDLE: begin
				if (data == 1)
					next_state = BEGIN;
			end
			
			BEGIN: begin
				if (data == 1)
					next_state = SEARCH;
				else
					next_state = IDLE;
			end
			
			SEARCH: begin
				if (data == 0)
					next_state = IDLE;
				else if (shift_reg == 4'b1101)
					next_state = SHIFT;
			end
			
			SHIFT: begin
				next_state = IDLE;
				start_shifting = 1;
			end
		endcase
	end
	
	// Shift register logic
	always_ff @(posedge clk) begin
		if (reset)
			shift_reg <= 0;
		else
			shift_reg <= {shift_reg[2:0], data};
	end
	
endmodule
