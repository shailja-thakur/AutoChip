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

    wire [3:0] p1_inputs;
    wire [3:0] p2_inputs;

    assign p1_inputs = {p1a, p1b, p1c, p1d};
    assign p2_inputs = {p2a, p2b, p2c, p2d};

    wire p1_output = ~(&p1_inputs);
    wire p2_output = ~(&p2_inputs);

    assign p1y = p1_output;
    assign p2y = p2_output;

endmodule
