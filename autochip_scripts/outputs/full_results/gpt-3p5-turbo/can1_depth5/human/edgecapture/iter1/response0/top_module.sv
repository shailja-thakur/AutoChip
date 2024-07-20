module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

	reg [31:0] in_previous;
	
	initial begin
		in_previous = 0;
		out = 0;
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			in_previous <= 0;
			out <= 0;
		end else begin
			in_previous <= in;
			out <= in_previous & ~in;
		end
	end

endmodule
