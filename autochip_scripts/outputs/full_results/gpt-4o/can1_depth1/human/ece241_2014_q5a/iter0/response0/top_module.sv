module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	typedef enum reg [1:0] {
		S_INITIAL = 2'd0,
		S_FLIP = 2'd1,
		S_PASS = 2'd2
	} state_t;

	state_t state, next_state;

	// State transition on the positive edge of the clock or asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S_INITIAL;
		else
			state <= next_state;
		end
	end

	// Moore FSM logic for next state
	always @(*) begin
		case (state)
			S_INITIAL: begin
				if (x == 1)
					next_state = S_FLIP;
				else
					next_state = S_INITIAL;
			end

			S_FLIP: begin
				next_state = S_PASS;
			end

			S_PASS: begin
				next_state = S_PASS;
			end

			default: next_state = S_INITIAL;
		endcase
	end

	// Output logic - Moore machine: output only depends on current state
	always @(*) begin
		case (state)
			S_INITIAL: z = 0;
			S_FLIP: z = 1;
			S_PASS: z = ~x;
			default: z = 0;
		endcase
	end

endmodule
