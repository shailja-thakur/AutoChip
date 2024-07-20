module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define state encoding
	typedef enum logic [1:0] {
		B = 2'b00,  // B state with output = 1
		A = 2'b01   // A state with output = 0
	} state_t;
	
	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			B: if (in) next_state = B;
			   else next_state = A;
			A: if (in) next_state = A;
			   else next_state = B;
			default: next_state = B;
		endcase
	end
	
	// State memory
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end
	
	// Output logic
	assign out = (state == B);

endmodule
