module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else begin
		if (state == 2'b00 && j)
			state <= 2'b01;
		else if (state == 2'b01 && k)
			state <= 2'b00;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
