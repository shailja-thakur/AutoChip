module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	reg [31:0] d_last;
	
	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
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
		in = 0;
		
		#10 reset = 0;
		
		#10 in = 32'hABCDE123;
		#10 in = 32'h98765432;
		#10 in = 32'h12345678;
		
		$finish;
	end
	
endmodule
