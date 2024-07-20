module top_module(
    input x,
    input y,
    output z);

    wire a, b; // Intermediate wires

    // Define gates
    assign a = x & ~y;
    assign b = ~x & y;

    // Define third gate
    assign z = a | b;
endmodule
