module top_module (
    input  [3:0] x,
    input  [3:0] y,
    output [4:0] sum
);

    // Assign the sum of the two inputs to the output
    assign sum = x + y;

endmodule
