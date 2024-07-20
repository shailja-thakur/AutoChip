module top_module (
    input [6:1] y,  // State encoding
    input w,        // Input signal
    output Y2,      // Next state signal for y[2]
    output Y4       // Next state signal for y[4]
);

    // Logic for next state signal Y2
    assign Y2 = (y[1] & ~w) | (y[4] & ~w);

    // Logic for next state signal Y4
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
