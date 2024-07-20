module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// State transition on clock's positive edge
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B; // Asynchronous reset to state B
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
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
			default: next_state = B;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 0;
			B: out = 1;
			default: out = 1;
		endcase
	end

endmodule
