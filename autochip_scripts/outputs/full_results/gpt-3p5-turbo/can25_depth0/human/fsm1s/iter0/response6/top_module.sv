module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg out_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Reset state B
		else begin
			case (state)
				2'b10: begin // State B
					if (in == 1'b0)
						state <= 2'b00; // Transition to state A
					else
						state <= 2'b10; // Remain in state B
				end
				2'b00: begin // State A
					if (in == 1'b0)
						state <= 2'b10; // Transition to state B
					else
						state <= 2'b00; // Remain in state A
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b10: out_reg <= 1'b1; // Output 1 in state B
			2'b00: out_reg <= 1'b0; // Output 0 in state A
		endcase
	end

	assign out = out_reg;

endmodule
