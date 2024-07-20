module top_module(
	input clk,
	input reset,
	input data,
	output reg shift_ena,
	output reg counting,
	input done_counting,
	output reg done,
	input ack );

	// State encoding
	typedef enum reg [2:0] {
		IDLE,
		DETECT_1,
		DETECT_11,
		DETECT_110,
		DETECT_1101,
		SHIFT,
		COUNT,
		DONE
	} state_t;
	
	state_t state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Combinational logic for next state and outputs
	always @(*) begin
		// Default assignments
		next_state = state;
		shift_ena = 0;
		counting = 0;
		done = 0;

		case (state)
			IDLE: begin
				if (data)
					next_state = DETECT_1;
			end
			DETECT_1: begin
				if (~data)
					next_state = IDLE;
				else
					next_state = DETECT_11;
			end
			DETECT_11: begin
				if (~data)
					next_state = DETECT_110;
				else
					next_state = IDLE;
			end
			DETECT_110: begin
				if (data)
					next_state = DETECT_1101;
				else
					next_state = IDLE;
			end
			DETECT_1101: begin
				if (data) begin
					next_state = SHIFT;
					shift_ena = 1;
				end
				else
					next_state = IDLE;
			end
			SHIFT: begin
				if (shift_ena == 4)
					next_state = COUNT;
				shift_ena = 1;
			end
			COUNT: begin
				counting = 1;
				if (done_counting)
					next_state = DONE;
			end
			DONE: begin
				done = 1;
				if (ack)
					next_state = IDLE;
			end
		endcase
	end
endmodule
