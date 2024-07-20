module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'd1; // Reset state B
		end else begin
			case (state)
				2'd1: begin // State B
					if (in) begin
						state <= 2'd1; // Stay in state B
					end else begin
						state <= 2'd0; // Transition to state A
					end
				end
				2'd0: begin // State A
					if (in) begin
						state <= 2'd0; // Stay in state A
					end else begin
						state <= 2'd1; // Transition to state B
					end
				end
				default: begin
					state <= 2'd1; // Default state is B
				end
			endcase
		end
	end
	
	assign out = (state == 2'd0) ? 1'b0 : 1'b1; // Output is 0 in state A, 1 in state B

endmodule
