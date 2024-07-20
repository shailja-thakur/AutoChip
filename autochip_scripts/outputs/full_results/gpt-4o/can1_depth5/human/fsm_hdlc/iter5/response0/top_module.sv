module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		IDLE         = 3'b000,
		ONE          = 3'b001,
		TWO          = 3'b010,
		THREE        = 3'b011,
		FOUR         = 3'b100,
		FIVE         = 3'b101,
		SIX          = 3'b110,
		SEVEN        = 3'b111
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
					disc = 1'b1; // Discard the bit due to zero after five 1s
					next_state = IDLE;
				end
			end

			SEVEN: begin
				if (in) begin
					err = 1'b1; // Error due to more than six 1s
				end
				else begin
					flag = 1'b1; // Flag for frame boundary
					next_state = IDLE;
				end
			end
			
			default: next_state = IDLE;
		endcase
	end

	// Output generation mechanism
	// Allow one extra cycle for outputs to be visible
	reg [2:0] output_state;
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			output_state <= 3'b000;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end
		else begin
			disc <= (output_state == SIX && !in);
			flag <= (output_state == SEVEN && !in);
			err <= (output_state == SEVEN && in);

			output_state <= state;
		end
	end
endmodule
