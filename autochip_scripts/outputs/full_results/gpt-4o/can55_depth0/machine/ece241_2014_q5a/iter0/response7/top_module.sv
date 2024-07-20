module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define the states using parameter
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;

	// State register
	reg [1:0] state, next_state;

	// Sequential block for state transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Combinational block for next state logic
	always @(*) begin
		case (state)
			A: next_state = (x) ? C : A;
			B: next_state = (x) ? B : C;
			C: next_state = (x) ? B : C;
			default: next_state = A; // Default case to avoid latches
		endcase
	end

	// Output logic based on the state
	always @(*) begin
		case (state)
			C: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
