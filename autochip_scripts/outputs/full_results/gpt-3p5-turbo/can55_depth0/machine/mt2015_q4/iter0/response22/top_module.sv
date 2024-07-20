module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    assign a = x;
    assign b = y;

    gate1 u1(.a(a), .b(b), .out1(a1));
    gate2 u2(.a(b), .b(a), .out2(b1));
    gate3 u3(.a(a1), .b(b1), .z(z));

    // Add gate modules here

endmodule
module gate1(
    input a,
    input b,
    output out1);

    // Add implementation here

endmodule
module gate2(
    input a,
    input b,
    output out2);

    // Add implementation here

endmodule
module gate3(
    input a,
    input b,
    output z);

    // Add implementation here

endmodule
