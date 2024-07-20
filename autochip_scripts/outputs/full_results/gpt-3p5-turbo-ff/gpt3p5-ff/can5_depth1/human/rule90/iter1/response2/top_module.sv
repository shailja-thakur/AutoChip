module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q[0] <= q[1] ^ q[511];
			for (int i = 1; i < 511; i = i + 1) begin
				q[i] <= q[i-1] ^ q[i+1];
			end
			q[511] <= q[510] ^ q[0];
		end
	end
	
	initial begin
		// Initialize q with 0s
		q = 512'b0;
		
		// Apply test input
		data = 512'b0101010101;
		load = 1;
		#1 load = 0;
		
		// Wait for simulation to complete
		#100;
		
		// Check the expected output
		if (q !== 512'b0010101010) begin
			$display("Test failed. Expected output: 0010101010. Actual output: %b", q);
			$finish;
		end else begin
			$display("Test passed!");
			$finish;
		end
	end
endmodule
