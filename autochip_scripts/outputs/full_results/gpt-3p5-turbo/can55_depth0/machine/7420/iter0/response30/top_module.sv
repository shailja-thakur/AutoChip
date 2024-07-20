module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    wire [4:1] p1_inputs;  // wire to hold the four inputs p1a, p1b, p1c, and p1d
    wire [4:1] p2_inputs;  // wire to hold the four inputs p2a, p2b, p2c, and p2d

    // assign inputs to p1_inputs and p2_inputs
    assign p1_inputs = {p1a, p1b, p1c, p1d};
    assign p2_inputs = {p2a, p2b, p2c, p2d};

    // assign p1y as the result of AND operation on p1_inputs inverted
    assign p1y = ~(&p1_inputs);

    // assign p2y as the result of AND operation on p2_inputs inverted
    assign p2y = ~(&p2_inputs);

endmodule
