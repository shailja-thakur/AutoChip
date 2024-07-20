module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State declaration
	reg [1:0] state;
	
	// Outputs declaration
	assign out = state[0];
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // Reset to state B
		end else begin
			case (state)
				2'b00: begin // State A, input '0'
					if (in) begin
						state <= 2'b01; // Transition to state A
					end else begin
						state <= 2'b00; // No state change
					end
				end
				2'b01: begin // State A, input '1'
					if (in) begin
						state <= 2'b00; // Transition to state B
					end else begin
						state <= 2'b01; // No state change
					end
				end
				2'b10: begin // State B, input '0'
					if (in) begin
						state <= 2'b10; // No state change
					end else begin
						state <= 2'b01; // Transition to state A
					end
				end
				2'b11: begin // State B, input '1'
					if (in) begin
						state <= 2'b11; // No state change
					end else begin
						state <= 2'b10; // Transition to state B
					end
				end
				default: state <= 2'b01; // Default state to B
			endcase
		end
	end

endmodule
