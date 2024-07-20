module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    /* This module is a simple adder which takes two 4-bit inputs (x and y)
     * and produces a 5-bit output (sum). The module contains no internal logic
     * and simply assigns the sum of the two inputs to the output.
     */
     
     assign {sum[4], sum[3:0]} = x + y;

endmodule
