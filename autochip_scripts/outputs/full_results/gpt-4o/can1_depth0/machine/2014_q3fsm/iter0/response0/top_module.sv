module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		S10 = 3'b011,
		S11 = 3'b100,
		S20 = 3'b101,
		S21 = 3'b110,
		S22 = 3'b111
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
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
			S20: next_state = B;
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
			default: next_state = A;
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		z = (current_state == S20 || current_state == S21 || current_state == S22);
	end

endmodule
