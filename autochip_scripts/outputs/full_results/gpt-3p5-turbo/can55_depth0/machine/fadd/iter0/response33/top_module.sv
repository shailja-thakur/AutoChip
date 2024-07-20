module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign {cout, sum} = a + b + cin >= 2 ? 2'b01 : 2'b00;

endmodule
