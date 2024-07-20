module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;

always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 2'b01; // Reset to state B
	else begin
		case (state)
			2'b00: begin // State A
				if (x)
					state <= 2'b01; // Transition to state B
				else
					state <= 2'b00; // Stay in state A
			end
			2'b01: begin // State B
				if (x)
					state <= 2'b01; // Stay in state B
				else
					state <= 2'b10; // Transition to state C
			end
			2'b10: begin // State C
				if (x)
					state <= 2'b10; // Stay in state C
				else
					state <= 2'b10; // Stay in state C
			end
		endcase
	end
end

always @(state) begin
	if (state == 2'b00)
		z <= 0; // Output z is 0 in state A
	else if (state == 2'b01)
		z <= 1; // Output z is 1 in state B
	else
		z <= 0; // Output z is 0 in state C
end

endmodule
