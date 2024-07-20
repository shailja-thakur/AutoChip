module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define states
	parameter OFF = 0;
	parameter ON = 1;

	reg [1:0] state;
	reg out;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
			out <= 0;
		end else begin
			case (state)
				OFF: begin
					if (j) begin
						state <= ON;
						out <= 0;
					end else begin
						state <= OFF;
						out <= 0;
					end
				end
				ON: begin
					if (k) begin
						state <= OFF;
						out <= 1;
					end else begin
						state <= ON;
						out <= 1;
					end
				end
				default: begin
					state <= OFF;
				end
			endcase
		end
	end

endmodule
