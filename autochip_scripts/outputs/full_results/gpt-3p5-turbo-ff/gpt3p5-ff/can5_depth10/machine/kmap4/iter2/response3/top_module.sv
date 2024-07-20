module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({a, b, c, d})
			4'b0000: out = 1'b0;
			4'b0001: out = 1'b0;
			4'b0010: out = 1'b0;
			4'b0011: out = 1'b0;
			4'b0100: out = 1'b0;
			4'b0101: out = 1'b0;
			4'b0110: out = 1'b0;
			4'b0111: out = 1'b0;
			4'b1000: out = 1'b0;
			4'b1001: out = 1'b0;
			4'b1010: out = 1'b0;
			4'b1011: out = 1'b0;
			4'b1100: out = 1'b0;
			4'b1101: out = 1'b0;
			4'b1110: out = 1'b0;
			4'b1111: out = 1'b1;
		endcase
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		$display("Starting simulation...");
		#20;
		$a = 0;
		$b = 0;
		$c = 0;
		$d = 0;
		#10;
		$a = 1;
		$b = 0;
		$c = 0;
		$d = 1;
		#10;
		$a = 0;
		$b = 1;
		$c = 1;
		$d = 1;
		#10;
		$a = 1;
		$b = 1;
		$c = 1;
		$d = 1;
		#10;
		$display("Simulation completed!");
		$finish;
	end
endmodule
