module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset == 1'b1)
		state <= 2'b01;
	else begin
		case(state)
			2'b00: begin
				if (in == 1'b0)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
			2'b01: begin
				if (in == 1'b0)
					state <= 2'b10;
				else
					state <= 2'b01;
			end
			2'b10: begin
				if (in == 1'b0)
					state <= 2'b01;
				else
					state <= 2'b10;
			end
		endcase
	end
end

always @* begin
	case(state)
		2'b00: out = 1'b0;
		2'b01: out = 1'b1;
		2'b10: out = 1'b0;
	endcase
end

endmodule
