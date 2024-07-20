module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    assign out1 = x & y;  // first gate: AND gate, output is out1
    assign out2 = x | y;  // second gate: OR gate, output is out2
    assign z = out1 ^ out2;  // third gate: XOR gate, output is z

endmodule
