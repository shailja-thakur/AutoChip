module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*)
begin
	// Initialize pos to zero in case no bits are high
	pos = 3'd0;
	
	// Loop through each bit of the input vector
	for(int i=0; i<8; i=i+1)
	begin
		// Check if the current bit is high
		if(in[i]==1'b1)
		begin
			// Set pos to the index of the first high bit
			pos = i;
			// Exit the loop since we only need to find the first high bit
			break;
		end
	end
end

endmodule
