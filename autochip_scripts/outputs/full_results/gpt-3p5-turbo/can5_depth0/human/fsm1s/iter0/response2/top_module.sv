module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b10;  // B state
		out <= 1;  // Output of B state is 1
	end else begin
		case (state)
			2'b10: begin  // B state
				if (in) begin
					state <= 2'b10;  // Stay in B state
				end else begin
					state <= 2'b01;  // Transition to A state
				end
				out <= 1;  // Output of B state is 1
			end
			
			2'b01: begin  // A state
				if (in) begin
					state <= 2'b01;  // Stay in A state
				end else begin
					state <= 2'b10;  // Transition to B state
				end
				out <= 0;  // Output of A state is 0
			end
		endcase
	end
end

endmodule
