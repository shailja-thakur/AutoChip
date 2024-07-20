module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;  // 2-bit state register
reg out_reg;     // output register

// state definitions
parameter OFF = 2'b00;
parameter ON = 2'b01;

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
				if (!k)
					state <= ON;
				else
					state <= OFF;
			end
		endcase
	end
end

always @(state) begin
	case (state)
		OFF: out_reg = 0;
		ON: out_reg = 1;
	endcase
end

assign out = out_reg;

endmodule
