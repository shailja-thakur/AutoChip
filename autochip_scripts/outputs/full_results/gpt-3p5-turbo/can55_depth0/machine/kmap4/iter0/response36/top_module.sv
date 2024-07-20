module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

	always @(*)
	begin
		case({a,b,c,d}) // Combine the four inputs into a 4-bit vector
		4'b0000: out = 1'b0; // If a, b, c, and d are all 0, output is 0
		4'b1111: out = 1'b1; // If a, b, c, and d are all 1, output is 1
		default: out = 1'b0; // For any other combination, output is 0
		endcase
	end
	
endmodule
