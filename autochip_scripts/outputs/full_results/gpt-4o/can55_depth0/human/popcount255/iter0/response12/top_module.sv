module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	integer i;
	always @(*) begin
		out = 8'd0; // Initialize the output to 0
		for (i = 0; i < 255; i = i + 1) begin
			out = out + in[i]; // Add the value of each bit in the input to the output
		end
	end

endmodule
