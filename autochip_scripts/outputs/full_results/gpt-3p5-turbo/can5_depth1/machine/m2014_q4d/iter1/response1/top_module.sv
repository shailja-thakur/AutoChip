module top_module (
	input clk,
	input in,
	output logic out
);
	always_ff @(posedge clk) begin
		out <= in ^ out;
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		
		// Initialize signals
		clk = 0;
		in = 0;
		
		#5 clk = 1;
		#5 in = 1;
		#5 in = 0;
		#5 in = 1;
		#5 in = 0;
		#5 in = 1;
		#5 in = 0;
		
		$finish;
	end
endmodule
