module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;
wire rising_edge;

assign rising_edge = x & ~x; // Detect rising edge of x

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A; // Reset state to A
	end else begin
		case (state)
			A: begin
				if (rising_edge) begin
					state <= B; // Move to state B on rising edge
				end
				// else: Remain in state A
			end
			B: begin
				// Remain in state B
			end
		endcase
	end
end

assign z = (state == A && x) || (state == B && ~x) ? 1'b1 : 1'b0; // Set output z based on the state and x input

endmodule
