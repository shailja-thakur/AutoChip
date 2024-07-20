module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	// Initial state
	initial begin
		q = 3'b000;
	end

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100; // Set q to 4 when a is 1
		end else if (q == 6) begin
			q <= 3'b000; // Set q to 0 when a is 0 and q is 6
		end else begin
			q <= q + 1; // Increment q by 1 when a is 0 and q is not 6
		end
	end
endmodule
