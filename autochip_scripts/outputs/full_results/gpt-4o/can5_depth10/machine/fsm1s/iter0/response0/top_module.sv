module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
    
	// State encoding
	parameter A = 1'b0, B = 1'b1;
    
	// State register
	reg state, next_state;

	// Combinational logic for next state determination
	always @(*) begin
		case (state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
			default: next_state = B; // Default state on reset
		endcase
	end

	// Sequential logic for state update
	always @(posedge clk or posedge reset) begin
		if (reset) state <= B; // Initial state on reset
		else state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) out <= 1'b1; // Output high if reset, indicating state B
		else out <= state;
	end

endmodule
