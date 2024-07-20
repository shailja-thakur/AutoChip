module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign {cout, sum} = a + b + cin;
    assign cout = (a + b + cin >= 2'b10) ? 1'b1 : 1'b0;
    assign sum = (a + b + cin) % 2;

endmodule
