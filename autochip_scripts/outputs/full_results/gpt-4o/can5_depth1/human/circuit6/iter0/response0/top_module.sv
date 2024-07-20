module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case (a)
			3'd0: q = 16'h1232; // For input 0, output 0x1232
			3'd1: q = 16'haee0; // For input 1, output 0xaee0
			3'd2: q = 16'h27d4; // For input 2, output 0x27d4
			3'd3: q = 16'h5a0e; // For input 3, output 0x5a0e
			3'd4: q = 16'h2066; // For input 4, output 0x2066
			3'd5: q = 16'h64ce; // For input 5, output 0x64ce
			3'd6: q = 16'hc526; // For input 6, output 0xc526
			3'd7: q = 16'h2f19; // For input 7, output 0x2f19
			default: q = 16'h0000; // Default output if a is out of bounds
		endcase
	end

endmodule
