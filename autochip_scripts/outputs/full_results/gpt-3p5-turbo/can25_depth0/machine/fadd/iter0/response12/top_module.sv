module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign {cout, sum} = (a + b + cin) >= 2'b10 ? 2'b1 : 2'b0;

endmodule
