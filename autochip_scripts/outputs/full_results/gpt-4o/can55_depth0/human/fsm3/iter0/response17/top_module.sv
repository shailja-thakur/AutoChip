module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    
	// Define state encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	// State variables
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A;  // Default case to handle unexpected conditions
		endcase
	end

	// Output logic: Moore output depends only on the current state
	always @(*) begin
		case (state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0;  // Default case for safety
		endcase
	end

	// State register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;  // Asynchronous reset to state A
		else
			state <= next_state;
		end
endmodule
