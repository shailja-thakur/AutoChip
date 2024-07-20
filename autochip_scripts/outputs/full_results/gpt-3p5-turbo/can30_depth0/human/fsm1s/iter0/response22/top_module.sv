module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= 2'b10; // Reset state B
		end else begin
			case (state)
				2'b10: begin // State B
					if (in == 1'b0) begin
						state <= 2'b01; // Transition to state A
						out <= 1'b1; // Set output to 1
					end else begin
						state <= 2'b10; // Stay in state B
					end
				end
				2'b01: begin // State A
					if (in == 1'b0) begin
						state <= 2'b10; // Transition to state B
					end else begin
						state <= 2'b01; // Stay in state A
						out <= 1'b0; // Set output to 0
					end
				end
			endcase
		end
	end
endmodule
