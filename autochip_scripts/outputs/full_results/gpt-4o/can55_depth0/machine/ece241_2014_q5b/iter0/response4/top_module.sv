module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	
	// Define state parameters
	parameter A = 1'b0, B = 1'b1;

	// State register
	reg state, next_state;

	// State transition
	always @ (posedge clk or posedge areset) begin
		if (areset) 
			state <= A;  // Asynchronous reset
		else 
			state <= next_state;
	end

	// Next state logic
	always @ (*)
	begin
		case (state)
			A: if (x) next_state = B;
			   else next_state = A;
			B: next_state = B;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @ (*)
	begin
		case (state)
			A: z = x;
			B: z = ~x;
			default: z = 0;
		endcase
	end

endmodule
