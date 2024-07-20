module top_module(
    output reg one);

    always @(posedge clk)
        one <= 1'b1;

endmodule
