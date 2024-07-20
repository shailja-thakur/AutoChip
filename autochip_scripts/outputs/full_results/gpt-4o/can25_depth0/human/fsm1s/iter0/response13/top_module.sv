module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		B = 2'b01,
		A = 2'b10
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = B; // Should not happen
		endcase
	end

	// Output logic: Moore machine output depends on current state only
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1; // Should not happen
		endcase
	end

	// State register with synchronous reset logic
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

endmodule
