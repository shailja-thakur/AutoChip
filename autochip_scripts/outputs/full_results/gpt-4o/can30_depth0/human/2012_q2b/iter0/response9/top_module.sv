module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding using one-hot
    // y[0]: A
    // y[1]: B
    // y[2]: C
    // y[3]: D
    // y[4]: E
    // y[5]: F

    // Next state logic for Y1 (B state)
    assign Y1 = (y[0] & w); // A --1--> B

    // Next state logic for Y3 (D state)
    assign Y3 = (y[1] & ~w) | // B --0--> D
                (y[2] & ~w) | // C --0--> D
                (y[5] & ~w);  // F --0--> D

endmodule
