// Build a circuit that has two 3-bit inputs that computes 
// the bitwise-OR of the two vectors, the logical-OR of the two vectors, 
and the inverse (NOT) of both vectors. Place the inverse of b in 
// the upper half of out_not (i.e., bits [5:3]), and the inverse of a in the lower half.

// Hint: Even though you cannot assign to a wire more than once, 
// you can use a part select on the left-hand-side of an assign. 
// You don't need to assign to the entire vector all in one statement.

module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

// Insert your code here

endmodule
