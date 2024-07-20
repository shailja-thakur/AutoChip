module top_module(
	input clk,
	input reset,
	input data,
	output reg shift_ena,
	output reg counting,
	input done_counting,
	output reg done,
	input ack);

	// State Definitions
	typedef enum reg[2:0] {
		STATE_SEARCH = 3'd0,
		STATE_SHIFT = 3'd1,
		STATE_WAIT_COUNT = 3'd2,
		STATE_DONE = 3'd3
	} state_t;

	state_t state, next_state;
	reg [2:0] bit_count;

	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= STATE_SEARCH;
		else 
			state <= next_state;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) 
			bit_count <= 3'd0;
		else if (state == STATE_SHIFT) 
			bit_count <= bit_count + 1;
		else
			bit_count <= 3'd0;
	end

	always @(*) begin
		// Default values
		next_state = state;
		shift_ena = 1'b0;
		counting = 1'b0;
		done = 1'b0;

		case (state)
			STATE_SEARCH: begin
				if ({data, bit_count[2:0]} == 4'b1101) 
					next_state = STATE_SHIFT;
			end
			STATE_SHIFT: begin
				shift_ena = 1'b1;
				if (bit_count == 3'd3)
					next_state = STATE_WAIT_COUNT;
			end
			STATE_WAIT_COUNT: begin
				counting = 1'b1;
				if (done_counting)
					next_state = STATE_DONE;
			end
			STATE_DONE: begin
				done = 1'b1;
				if (ack)
					next_state = STATE_SEARCH;
			end
		endcase
	end
endmodule
