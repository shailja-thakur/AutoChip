module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum reg [2:0] {
		A = 3'h0,
		B = 3'h1,
		C = 3'h2,
		S10 = 3'h3,
		S11 = 3'h4,
		S20 = 3'h5,
		S21 = 3'h6,
		S22 = 3'h7
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A;
			end

			B: begin
				if (w)
					next_state = S11;
				else
					next_state = S10;
			end

			C: begin
				if (w)
					next_state = S11;
				else
					next_state = S10;
			end

			S10: begin
				if (w)
					next_state = S21;
				else
					next_state = S20;
			end

			S11: begin
				if (w)
					next_state = S22;
				else
					next_state = S21;
			end

			S20: begin
				next_state = B;
			end

			S21: begin
				if (w)
					next_state = C;
				else
					next_state = B;
			end

			S22: begin
				if (w)
					next_state = B;
				else
					next_state = C;
			end

			default: begin
				next_state = A;
			end
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 0;
		else begin
			// z output logic can be filled in as needed based on the state
			case (state)
				// Define z update logic for each state if necessary
				default: z <= 0; // Default z value
			endcase
		end
	end
endmodule
