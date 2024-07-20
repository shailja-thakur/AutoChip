module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [3:0] state;
reg done_reg;

always @(posedge clk) begin
	if (reset)
		state <= 4'b0000;
	else if (state == 4'b0000 && in[3] == 1'b1)
		state <= 4'b0001;
	else if (state == 4'b0001)
		state <= 4'b0010;
	else if (state == 4'b0010)
		state <= 4'b0011;
	else if (state == 4'b0011)
		state <= 4'b0100;
	else if (state == 4'b0100)
		state <= 4'b0001;
end

always @(posedge clk) begin
	if (reset)
		done_reg <= 1'b0;
	else if (state == 4'b0100)
		done_reg <= 1'b1;
	else
		done_reg <= 1'b0;
end

assign done = done_reg;

endmodule
