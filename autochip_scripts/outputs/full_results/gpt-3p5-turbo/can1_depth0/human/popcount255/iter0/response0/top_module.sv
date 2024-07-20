module top_module (
	input [254:0] in,
	output reg [7:0] out
);
	
	always @* begin
		// initialize output count as 0
		out = 0;
		
		// loop through each bit of the input vector
		for (int i = 0; i < 255; i = i + 1) begin
			// if current bit is 1, increment count
			if (in[i] == 1'b1) begin
				out = out + 1;
			end
		end
	end
endmodule
