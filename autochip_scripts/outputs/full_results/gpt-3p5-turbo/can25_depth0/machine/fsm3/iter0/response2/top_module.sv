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
		state <= 2'b00; // Reset to state A
	end else begin
		case (state)
			2'b00: begin // State A
				if (in) begin
					state <= 2'b01; // Next state B
				else
					state <= 2'b00; // Next state A
				end
			end
			2'b01: begin // State B
				if (in) begin
					state <= 2'b01; // Next state B
				else
					state <= 2'b10; // Next state C
				end
			end
			2'b10: begin // State C
				if (in) begin
					state <= 2'b11; // Next state D
				else
					state <= 2'b00; // Next state A
				end
			end
			2'b11: begin // State D
				if (in) begin
					state <= 2'b01; // Next state B
				else
					state <= 2'b10; // Next state C
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 2'b11) begin // State D
		out <= 1;
	else
		out <= 0;
	end
end

endmodule
