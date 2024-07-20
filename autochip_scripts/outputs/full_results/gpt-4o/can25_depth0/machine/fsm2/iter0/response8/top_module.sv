module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	// Current state and next state
	reg current_state, next_state;

	// Combinational block to determine next state
	always @(*) begin
		case (current_state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A; // Default to state A
		endcase
	end

	// Clocked always block to update the state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= A; // Reset to state A
		end else begin
			current_state <= next_state;
		end
	end

	// Output assignment
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			out <= 1'b0; // Reset output to 0
		end else begin
			out <= (current_state == B) ? 1'b1 : 1'b0;
		end
	end

endmodule
