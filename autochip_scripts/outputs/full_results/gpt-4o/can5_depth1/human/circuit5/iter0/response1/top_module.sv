module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	always @(*) begin
		// Decoding 'c' and assigning the output 'q' based on the value of 'c'
		case (c)
			4'd0: q = b;
			4'd1: q = e;
			4'd2: q = a;
			4'd3: q = d;
			default: q = 4'b1111;  // For values 4 through 9, output is 'f' (binary 1111)
		endcase
	end
endmodule
