module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State Declaration 
	typedef enum reg {
		A = 1'b0,
		B = 1'b1
	} state_t;
	
	state_t state, next_state;

	// State Transition Logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next State Logic
	always @(*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;  // Default state if unknown/error state
		endcase
	end

	// Output Logic
	always @(state) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;  // Default output if unknown/error state
		endcase
	end
endmodule
