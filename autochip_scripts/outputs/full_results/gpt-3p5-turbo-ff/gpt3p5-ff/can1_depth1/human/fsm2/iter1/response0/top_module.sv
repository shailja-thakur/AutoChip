module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	reg [1:0] state;
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= OFF;
			out <= 1'b0; // Reset the output to 0
		end else begin
			case (state)
				ON: begin
					if (k) begin
						state <= OFF;
						out <= 1'b0; // Transition to state OFF, set output to 0
					end else begin
						state <= ON;
						out <= 1'b1; // Remain in state ON, set output to 1
					end
				end
				OFF: begin
					if (j) begin
						state <= ON;
						out <= 1'b1; // Transition to state ON, set output to 1
					end else begin
						state <= OFF;
						out <= 1'b0; // Remain in state OFF, set output to 0
					end
				end
			endcase
		end
	end

endmodule
