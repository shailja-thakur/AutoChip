// Create a 1-bit wide, 256-to-1 multiplexer. The 256 inputs are all packed into a 
// single 256-bit input vector. sel=0 should select in[0], sel=1 selects bits in[1], 
// sel=2 selects bits in[2], etc.

// Hint: With this many options, a case statement isn't so useful.
// Vector indices can be variable, as long as the synthesizer can figure out that 
// the width of the bits being selected is constant. In particular, 
// selecting one bit out of a vector using a variable index will work.


module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );

    //Insert your code here

endmodule
