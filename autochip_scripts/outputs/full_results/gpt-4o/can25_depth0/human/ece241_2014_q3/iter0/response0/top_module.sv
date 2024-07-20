module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Calculate the values for each entry in the Karnaugh map
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d); // equivalent to 1 because (c & d) covers all cases when c = 1
    assign mux_in[1] = 0;                             // 0
    assign mux_in[2] = (c & d);                       // 1 when both are 1
    assign mux_in[3] = (~c & ~d) | (c & d) | (~c & d); // basically 1 when c = 0 and d = 1 or both are same

endmodule
