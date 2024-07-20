module top_module(
    input x,
    input y,
    output z);

    // Define internal signals
    wire a1, b1, a2, b2;

    // Instantiate logic gates
    gate_1 g1 (.a=x, .b=y, .z1=a1, .z2=b1);
    gate_2 g2 (.a=b1, .b=a1, .z1=a2, .z2=b2);
    gate_3 g3 (.a=a2, .b=b2, .z=z);

endmodule
module gate_1(
    input a,
    input b,
    output z1,
    output z2);

    // Implement logic gate 1
    assign z1 = a & b;
    assign z2 = ~a & ~b;

endmodule
module gate_2(
    input a,
    input b,
    output z1,
    output z2);

    // Implement logic gate 2
    assign z1 = a | b;
    assign z2 = ~a | ~b;

endmodule
module gate_3(
    input a,
    input b,
    output z);

    // Implement logic gate 3
    assign z = a & b;

endmodule
