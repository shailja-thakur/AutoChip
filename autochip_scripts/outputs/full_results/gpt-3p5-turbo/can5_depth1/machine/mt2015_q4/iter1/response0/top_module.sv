module top_module(
	input x,
	input y,
	output reg z);
	
	wire a, b;

	and gate1(a, x, y);
	or gate2(b, x, y);
	and gate3(z, a, b);
	
	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		
		$display("Starting simulation...");
		
		// Apply inputs
		x = 0;
		y = 0;
		#10;
		x = 0;
		y = 1;
		#10;
		x = 1;
		y = 0;
		#10;
		x = 1;
		y = 1;
		#10;
		
		// End simulation
		$display("Simulation finished.");
		$finish;
	end
endmodule
