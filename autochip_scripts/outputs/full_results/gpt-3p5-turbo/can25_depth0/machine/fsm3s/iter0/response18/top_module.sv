module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	reg outreg;

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= 2'b00;  // reset to initial state A
		end else begin
			case (state)
				2'b00: begin  // State A
					if (in == 1'b1) begin
						state <= 2'b01;  // Change state to B
					else
						state <= 2'b00;  // Remain in state A
					end
				end
				2'b01: begin  // State B
					if (in == 1'b1) begin
						state <= 2'b01;  // Remain in state B
					else
						state <= 2'b10;  // Change state to C
					end
				end
				2'b10: begin  // State C
					if (in == 1'b1) begin
						state <= 2'b11;  // Change state to D
					else
						state <= 2'b00;  // Change state to A
					end
				end
				2'b11: begin  // State D
					if (in == 1'b1) begin
						state <= 2'b01;  // Change state to B
					else
						state <= 2'b10;  // Change state to C
					end
				end
				default: begin
					state <= 2'b00;  // Default to initial state A
				end
			endcase
		end
	end

	always @(state) begin
		if (state == 2'b11) begin
			outreg <= 1'b1;  // Set output to 1 when in state D
		else
			outreg <= 1'b0;
		end
	end

	assign out = outreg;

endmodule
