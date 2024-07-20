module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= OFF;
	else begin
		case(state)
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

always @(state, j, k) begin
	case(state)
		ON: out = 1'b1;
		OFF: out = 1'b0;
	endcase
end

endmodule
