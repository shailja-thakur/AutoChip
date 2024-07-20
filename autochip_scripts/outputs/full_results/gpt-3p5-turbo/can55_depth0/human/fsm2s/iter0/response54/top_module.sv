module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk) begin
	if (reset) begin
		state <= OFF;
		out <= 0;
	end else begin
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
		OFF: out <= 0;
		ON: out <= 1;
	endcase
end

endmodule
