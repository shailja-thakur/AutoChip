module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d;  // When ab = 00, mux_in[0] is connected to d (i.e. c=0, d=1 => 1; c=1, d=1 => 1; all other are 0)

    // ab = 01
    assign mux_in[1] = ~c & d;  // When ab = 01, mux_in[1] is connected to ~c & d (i.e. c=0, d=1 => 1; all other are 0)

    // ab = 11
    assign mux_in[3] = c;  // When ab = 11, mux_in[3] is connected to c (i.e. c=1, d=0 => 1; c=1, d=1 => 1; c=1, d=0 => 1)

    // ab = 10
    assign mux_in[2] = 1;  // When ab = 10, mux_in[2] is always 1

endmodule
