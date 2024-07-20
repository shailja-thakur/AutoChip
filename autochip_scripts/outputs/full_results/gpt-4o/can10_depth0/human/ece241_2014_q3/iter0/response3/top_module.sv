module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Intermediate signals for the 2-to-1 multiplexers
    wire cd_00, cd_01, cd_11, cd_10;

    // Implementing the values from the Karnaugh map for each combination of {c, d}
    assign cd_00 = ~c & ~d;
    assign cd_01 = ~c & d;
    assign cd_11 = c & d;
    assign cd_10 = c & ~d;

    // Using 2-to-1 multiplexers to assign the output mux_in based on {c, d}
    assign mux_in[0] = cd_00 ? 1'b0 : (cd_01 ? 1'b1 : (cd_11 ? 1'b1 : 1'b1));
    assign mux_in[1] = cd_00 ? 1'b0 : (cd_01 ? 1'b0 : (cd_11 ? 1'b0 : 1'b0));
    assign mux_in[2] = cd_00 ? 1'b0 : (cd_01 ? 1'b0 : (cd_11 ? 1'b1 : 1'b0));
    assign mux_in[3] = cd_00 ? 1'b1 : (cd_01 ? 1'b0 : (cd_11 ? 1'b1 : 1'b1));

endmodule
