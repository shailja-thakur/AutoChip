module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b1; // Reset state B
		end else begin
			case (state)
				2'b1: begin // State B
					if (in) begin
						state <= 2'b1; // Stay in state B
					end else begin
						state <= 2'b0; // Transition to state A
					end
				end
				2'b0: begin // State A
					if (in) begin
						state <= 2'b0; // Stay in state A
					end else begin
						state <= 2'b1; // Transition to state B
					end
				end
				default: begin
					state <= 2'b1; // Default state is B
				end
			endcase
		end
	end
	
	always @(state) begin
		out <= (state == 2'b0) ? 1'b0 : 1'b1; // Output is 0 in state A, 1 in state B
	end

endmodule
