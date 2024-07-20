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
	assign out = (state == ON) ? 1'b1 : 1'b0;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else begin
			case (state)
				ON: begin
					if (k)
						state <= OFF;
				end
				OFF: begin
					if (j)
						state <= ON;
				end
			endcase
		end
	end
endmodule
