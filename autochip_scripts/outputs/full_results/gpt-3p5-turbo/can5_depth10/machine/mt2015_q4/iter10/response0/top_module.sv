module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    assign a = x & y;  // AND gate to calculate a
    assign b = ~x & ~y;  // NAND gate to calculate b
    assign z = ~(a ^ b);  // NOT gate to calculate z

endmodule
