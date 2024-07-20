module top_module (
    input a,
    input b,
    input cin,
    output reg cout,
    output reg sum
);

    wire w1, w2, w3;

    assign w1 = a & b;
    assign w2 = a & cin;
    assign w3 = b & cin;

    assign sum = w1 ^ w2 ^ w3;
    assign cout = (w1 & w2) | (w1 & w3) | (w2 & w3);

endmodule
