module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // reset state to A
	end else begin
		case (state)
			2'b00: begin // State A
				state <= (in) ? 2'b01 : 2'b00; // Next state B if input is 1, else state A
			end
			2'b01: begin // State B
				state <= (in) ? 2'b01 : 2'b10; // Next state B if input is 1, else state C
			end
			2'b10: begin // State C
				state <= (in) ? 2'b11 : 2'b00; // Next state D if input is 1, else state A
			end
			2'b11: begin // State D
				state <= (in) ? 2'b01 : 2'b10; // Next state B if input is 1, else state C
			end
		endcase
	end

	out <= (state == 2'b11) ? 1'b1 : 1'b0; // Set the output to 1 when in state D, else 0
end

endmodule
