module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		S0, // No consecutive 1s
		S1, // 1 consecutive 1
		S2, // 2 consecutive 1s
		S3, // 3 consecutive 1s
		S4, // 4 consecutive 1s
		S5, // 5 consecutive 1s
		S6, // 6 consecutive 1s
		S7  // 7 or more consecutive 1s (error state)
	} state_t;

	state_t state, next_state;

	// FSM sequential logic
	always_ff @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// FSM combinational logic
	always_comb begin
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;
		next_state = state;

		case (state)
			S0: begin
				if (in)
					next_state = S1;
			end

			S1: begin
				if (in)
					next_state = S2;
				else
					next_state = S0;
			end

			S2: begin
				if (in)
					next_state = S3;
				else
					next_state = S0;
			end

			S3: begin
				if (in)
					next_state = S4;
				else
					next_state = S0;
			end

			S4: begin
				if (in)
					next_state = S5;
				else
					next_state = S0;
			end

			S5: begin
				if (in)
					next_state = S6;
				else
					next_state = S0;
			end

			S6: begin
				if (in)
					next_state = S7;
				else begin
					disc = 1'b1;
					next_state = S0;
				end
			end

			S7: begin
				if (in)
					err = 1'b1;
				else 
					flag = 1'b1;
				next_state = S0;
			end

			default: begin
				next_state = S0;
			end
		endcase
	end

endmodule
