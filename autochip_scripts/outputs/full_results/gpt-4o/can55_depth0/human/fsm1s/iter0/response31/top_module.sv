module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// States encoding
	typedef enum reg [1:0] {
		B = 2'b01,
		A = 2'b10
	} state_t;

	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			B: if (in)
					next_state = B;
				else
					next_state = A;
			A: if (in)
					next_state = A;
				else
					next_state = B;
			default: next_state = B;
		endcase
	end

	// State update logic
	always @(posedge clk) begin
		if (reset)
			state <= B; // Setting the reset state
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		case (state)
			B: out <= 1;
			A: out <= 0;
			default: out <= 1; // Default should never naturally happen
		endcase
	end

endmodule
