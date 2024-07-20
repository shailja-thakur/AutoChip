module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

// States declaration
typedef enum logic [1:0] {
	STATE_IDLE = 2'b00,   // Idle state: waiting for reset release
	STATE_ONE = 2'b01,    // State after first 1 encountered
	STATE_TWO = 2'b10     // State after flipping bits
} state_t;

state_t state, next_state;
logic flipped;

// State transitions
always_ff @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= STATE_IDLE;
		flipped <= 0;
		z <= 0;
	end
	else begin
		state <= next_state;
		if (state == STATE_TWO) 
			flipped <= !flipped;
	end
end

// Next state logic
always_comb begin
	case (state)
		STATE_IDLE: begin
			if (!areset) 
				next_state = (x) ? STATE_ONE : STATE_IDLE;
			else
				next_state = STATE_IDLE;
		end
		STATE_ONE: begin
			next_state = STATE_TWO;
		end
		STATE_TWO: begin
			if (areset)
				next_state = STATE_IDLE;
			else
				next_state = STATE_TWO;
		end
		default: begin
			next_state = STATE_IDLE;
		end
	endcase
end

// Output logic
always_ff @(posedge clk, posedge areset) begin
	if (areset) begin
		z <= 0;
	end
	else begin
		case (state)
			STATE_IDLE: z <= 0;
			STATE_ONE: z <= !x;
			STATE_TWO: z <= (flipped) ? x : !x;
			default: z <= 0;
		endcase
	end
end

endmodule
