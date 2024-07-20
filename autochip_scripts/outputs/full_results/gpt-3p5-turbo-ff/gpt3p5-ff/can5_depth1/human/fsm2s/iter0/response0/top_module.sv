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

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= OFF;
	else begin
		case (state)
			ON: begin
				if (k)
					state <= OFF;
				else
					state <= ON;
			end
			   
			OFF: begin
				if (j)
					state <= ON;
				else
					state <= OFF;
			end
		endcase
	end
end

always @* begin
	case (state)
		ON: out = 1'b1;
		OFF: out = 1'b0;
	endcase
end

endmodule
