module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		S0 = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100
	} state_t;

	state_t state, next_state;

	// State transition on clock edge
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			S0: next_state = x ? S1 : S0;
			S1: next_state = x ? S4 : S1;
			S2: next_state = x ? S1 : S2;
			S3: next_state = x ? S2 : S1;
			S4: next_state = x ? S4 : S3;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always_comb begin
		case (state)
			S3, S4: z = 1;
			default: z = 0;
		endcase
	end

endmodule
