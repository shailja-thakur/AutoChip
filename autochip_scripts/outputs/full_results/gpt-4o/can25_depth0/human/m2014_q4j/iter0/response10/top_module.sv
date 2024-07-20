module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    // Internal wires to connect the full adders
    wire c1, c2, c3, c4;
    wire s0, s1, s2, s3;

    // Instantiate the full adders
    full_adder fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .s(s0),
        .cout(c1)
    );

    full_adder fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .s(s1),
        .cout(c2)
    );

    full_adder fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .s(s2),
        .cout(c3)
    );

    full_adder fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .s(s3),
        .cout(c4)
    );

    // Combine the sum bits and the final carry-out
    assign sum = {c4, s3, s2, s1, s0};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output s,
    output cout
);
    assign {cout, s} = a + b + cin;
endmodule
