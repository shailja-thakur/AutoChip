module top_module(
    input in,
    output out
);

    // This module behaves like a wire, simply passing the input to the output
    assign out = in;

endmodule
