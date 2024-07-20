module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg temp;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else begin
		case(state)
			2'b00: begin
				if (x)
					state <= 2'b01;
			end
			2'b01: begin
				if (!x)
					state <= 2'b10;
			end
			2'b10: begin
				if (x)
					state <= 2'b01;
			end
			default: state <= 2'b00;
		endcase
	end
end

always @(state) begin
	case(state)
		2'b00: temp = 1'b0;
		2'b01: temp = 1'b1;
		2'b10: temp = 1'b1;
		default: temp = 1'b0;
	endcase
end

assign z = temp;

endmodule
