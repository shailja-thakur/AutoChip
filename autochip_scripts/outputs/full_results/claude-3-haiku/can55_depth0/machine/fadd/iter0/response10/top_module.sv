module top_module (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire cout,
    output wire sum
);

    assign {cout, sum} = a + b + cin;

endmodule
