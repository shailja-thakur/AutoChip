module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	typedef enum logic [2:0] {
		S0, // Initial state or after a reset (previous input considered as 0)
		S1, // Received one 1
		S2, // Received two consecutive 1s
		S3, // Received three consecutive 1s
		S4, // Received four consecutive 1s
		S5, // Received five consecutive 1s
		S6, // Received six consecutive 1s (possible disc or flag)
		S7  // Error state: Received seven or more consecutive 1s
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always_comb begin
		// Default values
		next_state = state;
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;

		case (state)
			S0: begin
				if (in == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			end

			S1: begin
				if (in == 1'b1) begin
					next_state = S2;
				end else begin
					next_state = S0;
				end
			end

			S2: begin
				if (in == 1'b1) begin
					next_state = S3;
				end else begin
					next_state = S0;
				end
			end

			S3: begin
				if (in == 1'b1) begin
					next_state = S4;
				end else begin
					next_state = S0;
				end
			end

			S4: begin
				if (in == 1'b1) begin
					next_state = S5;
				end else begin
					next_state = S0;
				end
			end

			S5: begin
				if (in == 1'b1) begin
					next_state = S6;
				end else begin
					next_state = S0;
				end
			end

			S6: begin
				if (in == 1'b1) begin
					next_state = S7;
					err = 1'b1;
				end else begin
					next_state = S0;
					disc = 1'b1;
				end
			end

			S7: begin
				if (in == 1'b1) begin
					next_state = S7;
					err = 1'b1;
				end else begin
					next_state = S0;
				end
			end

			default: begin
				next_state = S0;
			end
		endcase

		// Flag logic
		if (state == S6 && in == 1'b0) begin
			flag = 1'b1;
		end
	end
endmodule
