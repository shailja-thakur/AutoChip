module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;

always @(posedge clk) begin
	if (reset)
		state <= 2'b0;
	else if (state == 2'b00 && j)
		state <= 2'b01;
	else if (state == 2'b01 && !j)
		state <= 2'b00;
	else if (state == 2'b01 && k)
		state <= 2'b00;
	else if (state == 2'b00 && !k)
		state <= 2'b01;
end

assign out = (state == 2'b01);

endmodule
