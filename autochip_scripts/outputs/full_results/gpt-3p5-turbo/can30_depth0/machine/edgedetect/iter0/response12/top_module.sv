module top_module(
	input wire clk,
	input wire [7:0] in,
	output wire [7:0] pedge);

reg [7:0] d_last;

always @(posedge clk) begin
	d_last <= in;
	pedge <= in & ~d_last;
end

endmodule
