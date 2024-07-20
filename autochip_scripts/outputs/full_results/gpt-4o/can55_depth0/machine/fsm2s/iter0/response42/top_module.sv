module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State declarations
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t current_state, next_state;

	// State transitioning
	always @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (current_state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			out <= 1'b0;
		else
			out <= (current_state == B) ? 1'b1 : 1'b0;
		end
endmodule
