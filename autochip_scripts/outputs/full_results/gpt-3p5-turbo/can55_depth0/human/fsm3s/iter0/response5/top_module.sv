module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state; // 2-bit register to represent the current state

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // Reset state to A
		else begin
			case (state)
				2'b00: begin // State A
					if (in)
						state <= 2'b01; // Next state B
				end
				
				2'b01: begin // State B
					if (in)
						state <= 2'b01; // Next state B
					else
						state <= 2'b10; // Next state C
				end
				
				2'b10: begin // State C
					if (in)
						state <= 2'b00; // Next state A
					else
						state <= 2'b11; // Next state D
				end
				
				2'b11: begin // State D
					if (in)
						state <= 2'b10; // Next state C
				end
			endcase
		end
	end

	// Output assign
	always @(state) begin
		case (state)
			2'b00: out = 1'b0; // State A, Output 0
			2'b01: out = 1'b0; // State B, Output 0
			2'b10: out = 1'b1; // State C, Output 1
			2'b11: out = 1'b0; // State D, Output 0
		endcase
	end

endmodule
