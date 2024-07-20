module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    // Perform the addition and assign the result to 'sum'
    assign sum = x + y;

endmodule
