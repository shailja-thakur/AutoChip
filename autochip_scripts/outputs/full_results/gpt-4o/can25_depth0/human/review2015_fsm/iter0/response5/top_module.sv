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
		IDLE = 3'b000,
		SHIFT = 3'b001,
		COUNT = 3'b010,
		DONE = 3'b011,
		WAIT_ACK = 3'b100
	} state_t;

	// State register
	reg [2:0] state, next_state;
	reg [2:0] shift_count;
	reg [3:0] pattern_shift;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_count <= 3'd0;
			pattern_shift <= 4'd0;
		end else begin
			state <= next_state;
			if (shift_ena)
				shift_count <= shift_count + 1;
			if (state == IDLE || state == SHIFT)
				pattern_shift <= {pattern_shift[2:0], data};
		end
	end

	// Next state logic
	always @(*) begin
		// Default values
		next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

		case (state)
			IDLE: begin
				if (pattern_shift == 4'b1101)
					next_state = SHIFT;
			end
			SHIFT: begin
				shift_ena = 1'b1;
				if (shift_count == 3'd3)
					next_state = COUNT;
			end
			COUNT: begin
				counting = 1'b1;
				if (done_counting)
					next_state = DONE;
			end
			DONE: begin
				done = 1'b1;
				if (ack)
					next_state = IDLE;
			end
		endcase
	end
endmodule
