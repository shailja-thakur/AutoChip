module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	
	// Define the two states of the state machine
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	// Register to store the state of the state machine
	reg [1:0] state;
	
	// Synchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;  // Reset the state to A
			z <= 0;  // Reset the output to 0
		end
		else begin
			// Determine the state based on the current state and input x
			case (state)
				A: begin
					if (x) begin
						state <= B;  // Transition to state B
						z <= 1;  // Set the output to 1
					end
					else begin
						state <= A;  // Stay in state A
						z <= 0;  // Set the output to 0
					end
				end
				
				B: begin
					state <= B;  // Stay in state B
					z <= ~x;  // Set the output to the complement of x
				end
			endcase
		end
	end

endmodule
