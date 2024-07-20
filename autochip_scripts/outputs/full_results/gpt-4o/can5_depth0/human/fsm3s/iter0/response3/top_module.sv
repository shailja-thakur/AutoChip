module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State Encoding
	typedef enum reg [1:0] {
		S_A = 2'b00,
		S_B = 2'b01,
		S_C = 2'b10,
		S_D = 2'b11
	} state_t;
	
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
			S_A: next_state = in ? S_B : S_A;
			S_B: next_state = in ? S_B : S_C;
			S_C: next_state = in ? S_D : S_A;
			S_D: next_state = in ? S_B : S_C;
			default: next_state = S_A;
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			S_A: out = 1'b0;
			S_B: out = 1'b0;
			S_C: out = 1'b0;
			S_D: out = 1'b1;
			default: out = 1'b0;
		endcase
	}

	// State Update Logic with Synchronous Reset
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= S_A;
		else 
			state <= next_state;
	end
	
endmodule
