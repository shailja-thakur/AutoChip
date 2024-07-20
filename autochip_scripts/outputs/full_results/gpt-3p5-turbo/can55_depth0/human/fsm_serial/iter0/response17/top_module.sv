module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// State enumeration
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// State register
	reg state_t current_state, next_state;

	// Output register
	reg done_reg;

	// Synchronous reset
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Output assignment
	assign done = done_reg;

	// Next state logic
	always_comb begin
		case (current_state)
			IDLE: begin
				if (in == 1'b0)
					next_state = START_BIT;
				else
					next_state = IDLE;
			end
			START_BIT: begin
				next_state = DATA_BITS;
			end
			DATA_BITS: begin
				next_state = STOP_BIT;
			end
			STOP_BIT: begin
				next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output generation
	always_comb begin
		if (current_state == STOP_BIT)
			done_reg = 1'b1;
		else
			done_reg = 1'b0;
	end

endmodule
