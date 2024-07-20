module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State encoding
	typedef enum logic [1:0] {
		B = 2'b00,
		A = 2'b01
	} state_t;
	
	state_t state, next_state;
	
	// Output logic
	assign out = (state == B);
	
	// State transition logic
	always @(*) begin
		case (state)
			B: next_state = (in) ? B : A;
			A: next_state = (in) ? A : B;
			default: next_state = B;  // default case for safe coding
		endcase
	end
	
	// State register with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

endmodule
