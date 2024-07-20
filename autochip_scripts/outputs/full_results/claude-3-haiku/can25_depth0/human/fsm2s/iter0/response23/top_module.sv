module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

localparam OFF = 1'b0;
localparam ON = 1'b1;

reg state;

always @(posedge clk) begin
	if (reset)
		state <= OFF;
	else begin
		case (state)
			OFF: begin
				if (j)
					state <= ON;
				else
					state <= OFF;
			end
			ON: begin
				if (k)
					state <= OFF;
				else
					state <= ON;
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
