module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

// Register to store previous value of in signal
reg [7:0] d_last;

// Detecting any edge in the in signal
always @(posedge clk) begin
    d_last <= in;
    anyedge <= (in ^ d_last) != 0;
end

endmodule
