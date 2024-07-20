module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Declare state register
	reg [1:0] state;

	// Declare next state register
	reg [1:0] next_state;

	// Synchronous state update process
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // Reset state to B
		end else begin
			state <= next_state; // Update state
		end
	end

	// Combinational logic for next state calculation
	always @* begin
		case (state)
			2'b00: if (in) begin
					  next_state = 2'b00; // Stay in state A
				  end else begin
					  next_state = 2'b01; // Transition to state B
				  end
			2'b01: if (in) begin
					  next_state = 2'b01; // Stay in state B
				  end else begin
					  next_state = 2'b00; // Transition to state A
				  end
			default: next_state = 2'b01; // Default to state B
		endcase
	end

	// Output logic
	assign out = (state == 2'b01);

endmodule
