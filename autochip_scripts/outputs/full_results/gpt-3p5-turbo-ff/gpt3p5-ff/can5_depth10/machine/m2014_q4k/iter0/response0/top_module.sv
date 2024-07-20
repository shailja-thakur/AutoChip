module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// 4-bit shift register
	reg [3:0] sr;
	
	always @(posedge clk) begin
		if (resetn == 0)
			sr <= 4'b0000; // reset to all zeros
		else
			sr <= {sr[2:0], in}; // shift left by one bit and load input
	end
	
	assign out = sr[3]; // output is the most significant bit of the register
endmodule
