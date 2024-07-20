module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	reg [1:0] state_reg;  // Registers to store the current state
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= OFF;  // Reset state to OFF
		end else begin
			case (state_reg)
				ON: begin
					if (k) begin
						state_reg <= OFF;
					end
				end
				OFF: begin
					if (j) begin
						state_reg <= ON;
					end
				end
				default: state_reg <= OFF;  // Default state
			endcase
		end
	end

	assign out = (state_reg == ON) ? 1'b1 : 1'b0;  // Output logic
endmodule
