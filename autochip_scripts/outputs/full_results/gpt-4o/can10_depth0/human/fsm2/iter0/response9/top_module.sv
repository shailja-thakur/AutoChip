module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	// State encoding
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// State transitions
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic (Moore machine: output depends only on state)
	always @(*) begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
			default: out = 0;
		endcase
	end
endmodule
