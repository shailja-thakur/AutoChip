module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		q <= 8'b00000000; // reset q to 0 when reset is high
	end else begin
		q <= d; // store data input d to output q on clock's rising edge
	end
end

endmodule
