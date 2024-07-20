module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State Definition
	typedef enum logic [2:0] {
		IDLE      = 3'b000,
		ONE_1     = 3'b001,
		TWO_1S    = 3'b010,
		THREE_1S  = 3'b011,
		FOUR_1S   = 3'b100,
		FIVE_1S   = 3'b101,
		SIX_1S    = 3'b110,
		ERROR_1S  = 3'b111
	} state_t;

	state_t current_state, next_state;

	// State Register
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			disc   <= 0;
			flag   <= 0;
			err    <= 0;
		end
		else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		// Default outputs
		disc = 0;
		flag = 0;
		err  = 0;
		next_state = current_state;

		case (current_state)
			IDLE: begin
				if (in) next_state = ONE_1; 
			end
			ONE_1: begin
				if (in) next_state = TWO_1S;
				else next_state = IDLE;
			end
			TWO_1S: begin
				if (in) next_state = THREE_1S;
				else next_state = IDLE;
			end
			THREE_1S: begin
				if (in) next_state = FOUR_1S;
				else next_state = IDLE;
			end
			FOUR_1S: begin
				if (in) next_state = FIVE_1S;
				else next_state = IDLE;
			end
			FIVE_1S: begin
				if (in) next_state = SIX_1S;
				else next_state = IDLE;
			end
			SIX_1S: begin
				if (in) begin
					next_state = ERROR_1S;
					err = 1;
				end
				else begin
					next_state = IDLE;
					disc = 1;  // 0111110 detected
				end
			end
			ERROR_1S: begin
				if (!in) next_state = IDLE;
				// Remain in ERROR_1S state otherwise and assert `err`
				err = 1;
			end
		endcase

		// Detect Flag
		if (current_state == FIVE_1S && in == 1) begin
			flag = 1;  // 01111110 detected
		end
	end
endmodule
