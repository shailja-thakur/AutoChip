module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;
    
    // Logical OR operation
    assign out_or_logical = |(a | b);
    
    // Inverse (NOT) of both vectors
    // The inverse of 'b' is in bits [5:3] and inverse of 'a' is in bits [2:0]
    assign out_not = {~b, ~a};

endmodule
