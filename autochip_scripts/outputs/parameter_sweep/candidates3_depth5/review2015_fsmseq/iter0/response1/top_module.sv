module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	typedef enum logic [1:0] {
		IDLE,
		S1,
		S2,
		S3,
		S4,
		FOUND
	} fsm_state_t;
	
	// Define current state and next state variables
	reg fsm_state_t current_state;
	reg fsm_state_t next_state;
	
	// Initialize current state to IDLE
	initial begin
		current_state = IDLE;
	end
	
	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Combinational logic for next state and output generation
	always_comb begin
		case (current_state)
			IDLE: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = IDLE;
				end
			end
			
			S1: begin
				if (data) begin
					next_state = S2;
				end else begin
					next_state = IDLE;
				end
			end
			
			S2: begin
				if (data) begin
					next_state = S3;
				end else begin
					next_state = IDLE;
				end
			end
			
			S3: begin
				if (data) begin
					next_state = S4;
				end else begin
					next_state = IDLE;
				end
			end
			
			S4: begin
				if (data) begin
					next_state = FOUND;
				end else begin
					next_state = IDLE;
				end
			end
			
			FOUND: begin
				next_state = IDLE;
			end
		endcase
		
		// Output generation logic
		if (current_state == S4)
			start_shifting = 1;
		else
			start_shifting = 0;
	end
	
endmodule
