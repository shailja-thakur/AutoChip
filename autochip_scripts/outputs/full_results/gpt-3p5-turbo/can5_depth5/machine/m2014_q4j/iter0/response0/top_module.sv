module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    
    // Adder logic
    assign {sum[3], sum[2:0]} = x + y;

endmodule
