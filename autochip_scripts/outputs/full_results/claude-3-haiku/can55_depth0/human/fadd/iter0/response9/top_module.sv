module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_wire;
    wire cout_wire;

    assign sum_wire = a ^ b ^ cin;
    assign cout_wire = (a & b) | (a & cin) | (b & cin);

    assign sum = sum_wire;
    assign cout = cout_wire;

endmodule
