module top_module(
    input x,
    input y,
    output z
);

    wire a_out, b_out;

    // First gate
    and(a_out, x, y);

    // Second gate
    and(b_out, y, x);

    // Third gate
    and(z, a_out, b_out);

endmodule
