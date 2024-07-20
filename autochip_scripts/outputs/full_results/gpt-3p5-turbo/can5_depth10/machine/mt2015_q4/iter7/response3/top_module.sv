module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    assign #1 a = x & y;  // Added delay for correct simulation
    assign #1 b = y & x;  // Corrected the logic to perform AND operation
    assign #1 z = a ^ b;

endmodule
