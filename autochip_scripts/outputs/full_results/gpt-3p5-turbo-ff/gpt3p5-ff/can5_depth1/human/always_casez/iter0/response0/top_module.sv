module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*) begin
	pos = 0;
	
	// loop through the 8-bit input vector
	for (int i = 0; i < 8; i = i + 1) begin
		if (in[i] == 1'b1) begin
			pos = i;
			break; // exit the loop once the first high bit is found
		end
	end
end

endmodule
