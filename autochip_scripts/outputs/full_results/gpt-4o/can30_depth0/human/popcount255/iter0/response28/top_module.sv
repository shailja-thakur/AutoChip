module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	integer i;  // Define an integer for the loop

	always @(*) begin
		out = 8'd0;  // Initialize the output to zero
		for (i = 0; i < 255; i = i + 1) begin
			out = out + in[i];  // Count the number of '1's
		end
	end

endmodule
