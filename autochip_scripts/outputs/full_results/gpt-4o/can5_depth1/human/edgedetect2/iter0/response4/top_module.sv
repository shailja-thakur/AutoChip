module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] in_delayed;

	always @(posedge clk) begin
		in_delayed <= in; // Store previous value of 'in' on each clock cycle
		anyedge <= in & ~in_delayed; // Detect rising edge: 'in' is 1, previous value was 0
	end

endmodule
