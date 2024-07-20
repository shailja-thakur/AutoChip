module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	// State encoding
	typedef enum logic [2:0] {
		IDLE = 3'b000,
		S1   = 3'b001,
		S2   = 3'b010,
		S3   = 3'b011,
		S4   = 3'b100
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition
	always @(posedge clk) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (current_state)
			IDLE: if (data) next_state = S1; else next_state = IDLE;
			S1:   if (data) next_state = S2; else next_state = IDLE;
			S2:   if (data) next_state = S2; else next_state = S3;
			S3:   if (data) next_state = S4; else next_state = IDLE;
			S4:   next_state = S4;  // Remain in S4 once sequence detected
			default: next_state = IDLE;
		endcase
	end
	
	// Output logic
	always @(*) begin
		if (current_state == S4)
			start_shifting = 1;
		else
			start_shifting = 0;
	end

endmodule
