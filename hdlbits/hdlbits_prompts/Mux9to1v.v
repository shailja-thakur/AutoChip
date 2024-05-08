// Create a 16-bit wide, 9-to-1 multiplexer. sel=0 chooses a, sel=1 chooses b, etc. 
// For the unused cases (sel=9 to 15), set all output bits to '1'.

// Hint: With this many options, a case statement may be useful.

module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    //Insert your code here

endmodule