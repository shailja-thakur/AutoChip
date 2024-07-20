module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	// State encoding: state[1] = A, state[0] = B
	// Use one-hot encoding

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b10; // Reset to state A
		else begin
			case (state)
				2'b10: begin // State A
					if (x)
						state <= 2'b01; // Transition to state B on x=1
					else
						state <= 2'b10; // Stay in state A on x=0
				end

				2'b01: begin // State B
					if (x)
						state <= 2'b01; // Stay in state B on x=1
					else
						state <= 2'b10; // Transition to state A on x=0
				end
			endcase
		end
	end

	assign z = state[0]; // Output z is the least significant bit of the state

endmodule
