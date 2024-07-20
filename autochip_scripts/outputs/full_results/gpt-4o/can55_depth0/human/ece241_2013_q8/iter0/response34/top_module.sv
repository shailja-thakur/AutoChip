module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State encoding
	typedef enum logic [1:0] {
		IDLE = 2'b00,
		S1 = 2'b01,
		S10 = 2'b10
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			IDLE: if (x) next_state = S1; else next_state = IDLE;
			S1: if (x) next_state = S1; else next_state = S10;
			S10: if (x) next_state = S1; else next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// State register
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn) state <= IDLE;
		else state <= next_state;
	end

	// Output logic
	always @(*) begin
		z = (state == S10 && x);
	end

endmodule
