module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	// Initial state
	initial q = 3'b000;
	
	always @(posedge clk) begin
		if (a == 1) begin
			q <= 3'b100; // Set q to 4
		end else begin
			if (q == 3'b110) begin
				q <= 3'b000; // Set q to 0 if q is 6
			end else begin
				q <= q + 1; // Increment q
			end
		end
	end
endmodule
