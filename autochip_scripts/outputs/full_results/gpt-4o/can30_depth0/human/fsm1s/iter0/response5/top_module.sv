module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B: begin
				if (in == 0)
					next_state = A;
				else
					next_state = B;
			end
			A: begin
				if (in == 0)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = B; // Default to reset state
		endcase
	end

	// State update logic (synchronous reset)
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1; // Default to output of reset state
		endcase
	end

endmodule
