module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 0, B = 1;
	
	// State register
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end	
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = A; // Default state if undefined state occurs
		endcase
	end

	// Sequential block triggered on rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state;
	end

	// Output assignment
	assign out = (state == B);

endmodule
