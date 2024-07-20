module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	 
	 reg [7:0] pedge_delayed;
	 
	 // Delay input signal by one clock cycle
	 always @(posedge clk) begin
	 	pedge_delayed <= in;
	 end
	
	 // Detect positive edge detection
	 always @(*) begin
	 	pedge = pedge_delayed & ~in;
	 end
endmodule
