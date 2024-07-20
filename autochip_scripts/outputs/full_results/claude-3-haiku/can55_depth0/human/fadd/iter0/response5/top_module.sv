module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_wire;
    wire cout_wire;

    // Half adder for a + b
    assign sum_wire = a ^ b;
    assign cout_wire = a & b;

    // Full adder with carry-in
    assign sum = sum_wire ^ cin;
    assign cout = cout_wire | (sum_wire & cin);

endmodule
