module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;

parameter OFF = 2'b00;
parameter ON = 2'b01;

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
			default: state <= OFF;
		endcase
	end
end

assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
