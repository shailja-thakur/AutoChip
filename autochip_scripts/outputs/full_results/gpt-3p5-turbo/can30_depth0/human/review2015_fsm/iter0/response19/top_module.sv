module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	// State definitions
	typedef enum logic [2:0] {
		IDLE,
		DETECT_PATTERN,
		SHIFT_ENABLE,
		WAIT_COUNTING,
		DONE,
		WAIT_ACK
	} state_type;

	// State register and next state logic
	reg [2:0] state_reg, state_next;
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state_reg <= IDLE;
		else
			state_reg <= state_next;
	end

	// Output register
	reg shift_ena_reg, counting_reg, done_reg;
	always_comb
	begin
		shift_ena = shift_ena_reg;
		counting = counting_reg;
		done = done_reg;
	end

	// State transition logic
	always_comb
	begin
		// Default assignments
		state_next = state_reg;
		shift_ena_reg = 0;
		counting_reg = 0;
		done_reg = 0;
	
		case (state_reg)
			IDLE:
				if (data == 4'b1101)
					state_next = DETECT_PATTERN;
			DETECT_PATTERN:
				begin
					if (data == 4'b1101)
						state_next = DETECT_PATTERN;
					else
						state_next = SHIFT_ENABLE;
				end
			SHIFT_ENABLE:
				begin
					shift_ena_reg = 1;
					state_next = WAIT_COUNTING;
				end
			WAIT_COUNTING:
				begin
					counting_reg = 1;
					if (done_counting == 1)
						state_next = DONE;
				end
			DONE:
				begin
					done_reg = 1;
					state_next = WAIT_ACK;
				end
			WAIT_ACK:
				begin
					if (ack == 1)
						state_next = IDLE;
				end
			default:
				state_next = IDLE;
		endcase
	end
endmodule
