module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [3:0] {
		IDLE         = 4'b0000,
		ONE          = 4'b0001,
		TWO          = 4'b0010,
		THREE        = 4'b0011,
		FOUR         = 4'b0100,
		FIVE         = 4'b0101,
		SIX          = 4'b0110,
		SEVEN        = 4'b0111,
		DISCARD      = 4'b1000,
		FLAG         = 4'b1001,
		ERROR        = 4'b1010
	} state_t;

	state_t state, next_state;

	// Sequential logic for state transition
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Combinational logic for next state and outputs
	always_comb begin
		// Default next state and outputs
		next_state = state;
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;
		
		case (state)
			IDLE: begin
				if (in)
					next_state = ONE;
				else
					next_state = IDLE;
			end
			
			ONE: begin
				if (in)
					next_state = TWO;
				else
					next_state = IDLE;
			end

			TWO: begin
				if (in)
					next_state = THREE;
				else
					next_state = IDLE;
			end

			THREE: begin
				if (in)
					next_state = FOUR;
				else
					next_state = IDLE;
			end

			FOUR: begin
				if (in)
					next_state = FIVE;
				else
					next_state = IDLE;
			end

			FIVE: begin
				if (in)
					next_state = SIX;
				else
					next_state = IDLE;
			end

			SIX: begin
				if (in)
					next_state = SEVEN;
				else begin
					next_state = DISCARD; // 0111110 -> Stream contained 5 1s, discard the 0
				end
			end

			SEVEN: begin
				if (in) begin
					next_state = ERROR; // Error: more than 7 consecutive ones
				end
				else begin
					next_state = FLAG; // 01111110 -> 7th one followed by 0 indicates frame boundary
				end
			end
			
			DISCARD: begin
				disc = 1'b1;
				next_state = IDLE;
			end
			
			FLAG: begin
				flag = 1'b1;
				next_state = IDLE;
			end

			ERROR: begin
				err = 1'b1;
				next_state = IDLE;
			end
			
			default: next_state = IDLE;
		endcase
	end
endmodule
