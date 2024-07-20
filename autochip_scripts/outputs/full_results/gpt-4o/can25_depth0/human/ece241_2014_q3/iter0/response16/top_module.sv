module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire s0, s1, s2, s3;

    // Assign values to intermediate signals based on the truth table
    assign s0 = c & d;
    assign s1 = c & ~d;
    assign s2 = c;
    assign s3 = 1;

    // Assign these signals to the corresponding mux_in outputs
    assign mux_in[0] = s0 ? 1'b1 : 1'b0;  // (c & d)
    assign mux_in[1] = s1 ? 1'b1 : 1'b0;  // (c & ~d)
    assign mux_in[2] = s2 ? 1'b0 : 1'b0;  // 0
    assign mux_in[3] = s3 ? 1'b1 : 1'b0;  // 1

endmodule
