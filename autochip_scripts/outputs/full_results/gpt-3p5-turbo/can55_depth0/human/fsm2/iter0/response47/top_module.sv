module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
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
				ON: begin
					if (k == 0)
						state <= ON;
					else
						state <= OFF;
					out <= 1;
				end
				OFF: begin
					if (j == 0) 
						state <= OFF;
					else 
						state <= ON;
					out <= 0;
				end
			endcase
		end
	end
endmodule
