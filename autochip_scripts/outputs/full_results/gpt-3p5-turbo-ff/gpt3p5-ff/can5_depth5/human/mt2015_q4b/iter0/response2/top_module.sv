module top_module(
    input x,
    input y,
    output z);

    wire wire1;
    wire wire2;

    // Implement the logic for wire1
    assign wire1 = ~(x & y);

    // Implement the logic for wire2
    assign wire2 = ~(y & wire1);

    // Implement the logic for z
    assign z = ~(wire1 | wire2);

endmodule
