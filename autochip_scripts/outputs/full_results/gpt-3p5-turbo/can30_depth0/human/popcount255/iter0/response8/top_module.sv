module top_module (
	input [254:0] in,
	output reg [7:0] out
);
	
	// Intermediate signal to store the temporary count
	reg [7:0] count;
	
	// Population count circuit
	always @* begin
		count = 0;
		for (int i = 0; i < 255; i = i + 1) begin
			if (in[i] == 1'b1) begin
				count = count + 1'b1;
			end
		end
	end
	
	// Assign the count to the output
	assign out = count;
	
endmodule
