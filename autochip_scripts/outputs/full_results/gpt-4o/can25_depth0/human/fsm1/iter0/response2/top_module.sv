module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State definitions
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = B; // default state
		endcase
	end

	// State registers (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
		end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b1;
		endcase
	end
endmodule
