module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State machine states
	enum { IDLE, S0, S1, S2, S3 } state;
	// Next state and current state
	reg [2:0] next_state, current_state;

	// Initialize states
	always @ (posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Define the next state
	always @ (current_state, data) begin
		case(current_state)
			IDLE: begin
				if (data)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S0: begin
				if (data)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S1: begin
				if (data)
					next_state = S2;
				else
					next_state = IDLE;
			end
			S2: begin
				if (data)
					next_state = S3;
				else
					next_state = IDLE;
			end
			S3: begin
				if (data)
					next_state = S1;
				else
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @ (current_state) begin
		if (current_state == S3)
			start_shifting = 1;
		else
			start_shifting = 0;
	end

endmodule
