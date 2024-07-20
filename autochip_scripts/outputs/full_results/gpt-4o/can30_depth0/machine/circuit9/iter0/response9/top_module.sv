module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

    // Initial state for q
    initial q = 3'b000;

	always @(posedge clk) begin
		if (a)
			q <= 3'b100; // Set q to 4 when a is 1
		else if (q == 3'b110)
			q <= 3'b000; // Set q to 0 when a is 0 and q is 6
		else
			q <= q + 1; // Increment q by 1 when a is 0 and q is not 6
	end

endmodule
