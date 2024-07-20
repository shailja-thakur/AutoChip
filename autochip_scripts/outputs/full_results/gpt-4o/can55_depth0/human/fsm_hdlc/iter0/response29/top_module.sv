module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		RESET      = 3'd0,
		BIT0       = 3'd1,
		BIT1       = 3'd2,
		BIT11      = 3'd3,
		BIT111     = 3'd4,
		BIT1111    = 3'd5,
		BIT11111   = 3'd6,
		BIT111111  = 3'd7
	} state_t;
	
	state_t state, next_state;

	// Sequential state transition
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= RESET;
		else
			state <= next_state;
	end

	// Combinational next state logic
	always_comb begin
		disc = 0;
		flag = 0;
		err  = 0;
		next_state = state; // Default stay in the same state
		case (state)
			RESET: begin
				if (in)
					next_state = BIT0;
				else
					next_state = RESET;
			end
			BIT0: begin
				if (in)
					next_state = BIT1;
				else
					next_state = RESET;
			end
			BIT1: begin
				if (in)
					next_state = BIT11;
				else
					next_state = RESET;
			end
			BIT11: begin
				if (in)
					next_state = BIT111;
				else
					next_state = RESET;
			end
			BIT111: begin
				if (in)
					next_state = BIT1111;
				else
					next_state = RESET;
			end
			BIT1111: begin
				if (in)
					next_state = BIT11111;
				else
					next_state = RESET;
			end
			BIT11111: begin
				if (in)
					next_state = BIT111111;
				else begin
					next_state = RESET;
					disc = 1;
				end
			end
			BIT111111: begin
				if (in) begin
					next_state = RESET;
					err = 1;
				end else begin
					next_state = RESET;
					flag = 1;
				end
			end
			default: next_state = RESET;
		endcase
	end

endmodule
