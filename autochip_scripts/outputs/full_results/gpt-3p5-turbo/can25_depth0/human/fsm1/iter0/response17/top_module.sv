module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] current_state;
	wire out;

	// Next-state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= 2'b10; // Reset to state B
		end else begin
			case (current_state)
				2'b00: begin // State A
					if (in) begin
						current_state <= 2'b01; // Transition to state A
					end else begin
						current_state <= 2'b10; // Transition to state B
					end
				end
				2'b01: begin // State B
					if (in) begin
						current_state <= 2'b00; // Transition to state B
					end else begin
						current_state <= 2'b01; // Transition to state A
					end
				end
			endcase
		end
	end

	// Output logic
	always @(current_state) begin
		case (current_state)
			2'b00: out = 1'b0; // State A
			2'b01: out = 1'b1; // State B
		endcase
	end
endmodule
