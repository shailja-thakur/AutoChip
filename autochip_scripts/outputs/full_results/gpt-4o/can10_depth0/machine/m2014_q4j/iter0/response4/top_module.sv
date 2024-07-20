module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    // The sum is calculated by adding x and y
    assign sum = x + y;
endmodule
