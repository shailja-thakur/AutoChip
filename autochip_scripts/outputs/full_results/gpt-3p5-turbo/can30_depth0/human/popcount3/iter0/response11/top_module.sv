module top_module (
	input [2:0] in,
	output reg [1:0] out
);

always @(*) begin
	// initialize the count to 0
	out = 0;
	
	// count the number of '1's in the input vector
	for (int i = 0; i < 3; i = i + 1) begin
		if (in[i] == 1'b1)
			out = out + 1;
	end
end

endmodule
