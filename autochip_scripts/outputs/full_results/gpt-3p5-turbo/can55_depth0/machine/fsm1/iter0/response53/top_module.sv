module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 2'b01;
	else begin
		case(state)
			2'b00: begin
				if (in)
					state <= 2'b00;
				else
					state <= 2'b01;
			end
			2'b01: begin
				if (in)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
			default: state <= 2'b01;
		endcase
	end
end

always @(state) begin
	if (state == 2'b01)
		out_reg <= 1'b1;
	else
		out_reg <= 1'b0;
end

assign out = out_reg;

endmodule
