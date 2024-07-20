module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_w, cout_w1, cout_w2;

    assign sum_w = a ^ b ^ cin;
    assign cout_w1 = (a & b) | (a & cin) | (b & cin);
    assign cout_w2 = (a & b & cin);
    assign cout = cout_w1 | cout_w2;
    assign sum = sum_w;

endmodule
