module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
			d_last <= 0;
		end else begin
			d_last <= in;
			out <= out | (~in & d_last);
		end
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		clk = 0;
		reset = 1;
		#10 reset = 0;
	end

	always begin
		#5 clk = ~clk;
	end

endmodule
