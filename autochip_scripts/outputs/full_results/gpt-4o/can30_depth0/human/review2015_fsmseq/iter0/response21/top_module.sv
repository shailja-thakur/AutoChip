module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum reg [2:0] {
		IDLE = 3'd0,
		S1   = 3'd1,
		S2   = 3'd2,
		S3   = 3'd3,
		S4   = 3'd4,
		FOUND = 3'd5
	} state_t;

	state_t state, next_state;

	// State transition
	always @(posedge clk) begin
		if (reset) 
			state <= IDLE;
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: next_state = (data == 1'b1) ? S1 : IDLE;
			S1: next_state = (data == 1'b1) ? S2 : IDLE;
			S2: next_state = (data == 1'b0) ? S3 : IDLE;
			S3: next_state = (data == 1'b1) ? S4 : IDLE;
			S4: next_state = FOUND;
			FOUND: next_state = FOUND;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) 
			start_shifting <= 1'b0;
		else if (state == FOUND)
			start_shifting <= 1'b1;
	end
endmodule
