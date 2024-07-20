module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg out;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= OFF;
		out <= 0;
	end else begin
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

		case (state)
			OFF: out <= 0;
			ON: out <= 1;
		endcase
	end
end

endmodule
