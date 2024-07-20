module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 2'b01;
	else if (state == 2'b00 && in == 1'b0)
		state <= 2'b01;
	else if (state == 2'b00 && in == 1'b1)
		state <= 2'b00;
	else if (state == 2'b01 && in == 1'b0)
		state <= 2'b10;
	else if (state == 2'b01 && in == 1'b1)
		state <= 2'b01;
	else if (state == 2'b10 && in == 1'b0)
		state <= 2'b01;
	else if (state == 2'b10 && in == 1'b1)
		state <= 2'b10;
end

always @(posedge clk) begin
	case (state)
		2'b00: out <= 1'b0;
		2'b01: out <= 1'b1;
		2'b10: out <= 1'b1;
	endcase
end

endmodule
