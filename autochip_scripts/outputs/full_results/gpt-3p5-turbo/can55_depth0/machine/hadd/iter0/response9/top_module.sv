module top_module (
    input wire a,
    input wire b,
    output wire sum,
    output wire cout
);

    assign {cout, sum} = a + b;

endmodule
