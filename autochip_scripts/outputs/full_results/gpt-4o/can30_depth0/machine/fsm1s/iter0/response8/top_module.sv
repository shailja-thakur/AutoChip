module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declarations
	parameter A = 1'b0, B = 1'b1;
	reg state, next_state;
	
	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A; // Default to state A in case of invalid state
		endcase
	end

	// Sequential logic block to update state on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B; // Reset state to B
		end else begin
			state <= next_state; // Update state
		end
	end
	
	// Output logic
	assign out = (state == B);

endmodule
