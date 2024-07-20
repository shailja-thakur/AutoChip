module top_module(
    input x,
    input y,
    output z);

    assign z = #(5) (x & y);

endmodule
