module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 4'b0000;
		end else if (slowena) begin
			count <= count + 1;
		end
	end

	assign q = count;

endmodule
