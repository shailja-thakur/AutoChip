module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk) begin
	if (reset) begin
		state <= OFF;
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
			default: state <= OFF;
		endcase
	end
end

always @(state) begin
	case (state)
		ON: out = 1;
		OFF: out = 0;
		default: out = 0;
	endcase
end

endmodule
