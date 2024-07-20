module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		IDLE = 3'd0,
		ONE = 3'd1,
		TWO = 3'd2,
		THREE = 3'd3,
		FOUR = 3'd4,
		FIVE = 3'd5,
		SIX = 3'd6,
		SEVEN = 3'd7
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			disc <= (state == SIX && !in);
			flag <= (state == SIX && in);
			err <= (state == SEVEN);
		end
	end

	// Next state logic
	always_comb begin
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
				else 
					next_state = IDLE; // Zero bit after five ones
			end
			SEVEN: begin
				if (in) 
					next_state = SEVEN;
				else 
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

endmodule
