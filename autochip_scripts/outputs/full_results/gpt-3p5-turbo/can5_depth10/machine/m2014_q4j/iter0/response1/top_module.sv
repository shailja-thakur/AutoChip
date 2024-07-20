module top_module (
        input [3:0] x,
        input [3:0] y,
        output [4:0] sum
    );

    // Assigning the sum of x and y to the output
    assign sum = x + y;

endmodule
