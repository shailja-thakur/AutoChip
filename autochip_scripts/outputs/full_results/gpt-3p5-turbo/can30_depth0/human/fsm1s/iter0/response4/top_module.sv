module top_module (
	input wire clk,
	input wire in,
	input wire reset,
	output wire out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b01; // Reset state B
			out <= 1'b1; // Output is 1 in reset state B
		end else begin
			case (state)
				2'b01: begin // State B
					if (in) begin
						state <= 2'b01; // Stay in state B
						out <= 1'b1; // Output is 1 in state B
					end else begin
						state <= 2'b10; // Go to state A
						out <= 1'b0; // Output is 0 in state A
					end
				end
				
				2'b10: begin // State A
					if (in) begin
						state <= 2'b10; // Stay in state A
						out <= 1'b0; // Output is 0 in state A
					end else begin
						state <= 2'b01; // Go to state B
						out <= 1'b1; // Output is 1 in state B
					end
				end
			endcase
		end
	end
	
endmodule
