module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define the states as parameters
	parameter A = 1'b0, B = 1'b1;
	
	// Register to hold the current state
	reg state;

	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			state <= A;
		end else begin
			// State transitions
			case (state)
				A: if (x) state <= B;
				B: state <= B;
			endcase
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			A: z = x;
			B: z = 0;
			default: z = 0;
		endcase
	end

endmodule
