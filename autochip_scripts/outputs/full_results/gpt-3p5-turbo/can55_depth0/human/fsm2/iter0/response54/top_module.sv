module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	parameter OFF = 1'b0;
	parameter ON = 1'b1;

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else begin
			case (state)
				OFF: begin
					if (j)
						state <= ON;
				end
				ON: begin
					if (~k)
						state <= ON;
					else
						state <= OFF;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			OFF: out = 1'b0;
			ON: out = 1'b1;
		endcase
	end

endmodule
