module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum logic[2:0] {
		IDLE = 3'b000,
		S1   = 3'b001,
		S2   = 3'b010,
		S3   = 3'b011,
		S4   = 3'b100
	} state_t;

	state_t state, next_state;

	// Sequential logic (state transitions)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Combinational logic (next state and output logic)
	always @(*) begin
		// Default values
		next_state = state;

		case (state)
			IDLE: begin
				if (data)
					next_state = S1;
			end

			S1: begin
				if (data)
					next_state = S2;
				else
					next_state = IDLE;
			end

			S2: begin
				if (~data)
					next_state = S3;
				else
					next_state = S2;
			end

			S3: begin
				if (data)
					next_state = S4;
				else
					next_state = IDLE;
			end

			S4: begin
				start_shifting = 1;
				next_state = S4;
			end
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == S4)
			start_shifting <= 1'b1;
	end

endmodule
