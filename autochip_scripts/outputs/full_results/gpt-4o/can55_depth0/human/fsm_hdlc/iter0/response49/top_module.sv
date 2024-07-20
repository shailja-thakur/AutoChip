module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	typedef enum logic [2:0] {
		IDLE,      // Detect the first zero 
		ONE_1,     // Sequence of exactly one 1
		TWO_1,     // Sequence of exactly two consecutive 1s
        THREE_1,   // Sequence of exactly three consecutive 1s
        FOUR_1,    // Sequence of exactly four consecutive 1s
		FIVE_1,    // Sequence of exactly five consecutive 1s
		SIX_1,     // Sequence of exactly six consecutive 1s
		SEVEN_1,   // Sequence of seven or more consecutive 1s (signal error)
		DISCARD,   // State to signal a discard
		FLAG,      // State to signal a flag
		ERROR      // State to signal an error
	} state_t;

	state_t curr_state, next_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			curr_state <= IDLE;
		else
			curr_state <= next_state;
	end

	// Next state logic
	always_comb begin
		// Default assignments
		next_state = curr_state;
		disc = 0;
		flag = 0;
		err = 0;

		case (curr_state)
			IDLE: begin
				if (in) next_state = ONE_1;
				else next_state = IDLE;
			end
			ONE_1: begin
				if (in) next_state = TWO_1;
				else next_state = IDLE;
			end
			TWO_1: begin
				if (in) next_state = THREE_1;
				else next_state = IDLE;
			end
			THREE_1: begin
				if (in) next_state = FOUR_1;
				else next_state = IDLE;
			end
			FOUR_1: begin
				if (in) next_state = FIVE_1;
				else next_state = IDLE;
			end
			FIVE_1: begin
				if (in) next_state = SIX_1;
				else next_state = DISCARD;
			end
			SIX_1: begin
				if (in) next_state = SEVEN_1;
				else next_state = FLAG;
			end
			SEVEN_1: begin
				if (in) next_state = SEVEN_1; // remain in error state
				else next_state = ERROR;
			end
			DISCARD: begin
				disc = 1;
				next_state = IDLE;
			end
			FLAG: begin
				flag = 1;
				next_state = IDLE;
			end
			ERROR: begin
				err = 1;
				next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

endmodule
