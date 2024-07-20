module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0; // Reset state to OFF
	end else begin
		case (state)
			2'b00: // OFF
				if (j) begin
					state <= 2'b01; // Transition to ON
				end else begin
					state <= 2'b00; // Stay in OFF
				end
			2'b01: // ON
				if (k) begin
					state <= 2'b00; // Transition to OFF
				end else begin
					state <= 2'b01; // Stay in ON
				end
		endcase
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when in state ON

endmodule
