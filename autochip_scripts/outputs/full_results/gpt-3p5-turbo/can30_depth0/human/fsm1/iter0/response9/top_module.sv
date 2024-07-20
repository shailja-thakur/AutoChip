module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State declaration
	reg [1:0] state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b10; // Reset to state B
		else begin
			case (state)
				2'b00: // A
					if (in)
						state <= 2'b01; // Transition to state A
					else
						state <= 2'b10; // Transition to state B
				2'b01: // B
					if (in)
						state <= 2'b01; // Transition to state B
					else
						state <= 2'b00; // Transition to state A
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			2'b00: // A
				out <= 0;
			2'b01: // B
				out <= 1;
		endcase
	end

endmodule
