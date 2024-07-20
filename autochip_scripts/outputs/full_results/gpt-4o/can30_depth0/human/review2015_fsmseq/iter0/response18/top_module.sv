module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

    // States
	typedef enum reg [2:0] {
		S0,  // Initial state
		S1,  // State after recognizing first '1'
		S2,  // State after recognizing '11'
		S3,  // State after recognizing '110'
		S4   // State after recognizing '1101' sequence (final state)
	} state_t;
	
	state_t state, next_state;
	
	// State transition
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			S0: 
				if (data == 1)
					next_state = S1;
				else
					next_state = S0;
			S1: 
				if (data == 1)
					next_state = S2;
				else
					next_state = S0;
			S2: 
				if (data == 0)
					next_state = S3;
				else
					next_state = S2;
			S3: 
				if (data == 1)
					next_state = S4;
				else
					next_state = S0;
			S4: 
				next_state = S4;  // Remain in S4 once the sequence is found
			default: 
				next_state = S0;
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (state == S4)
			start_shifting <= 1;
	end
	
endmodule
