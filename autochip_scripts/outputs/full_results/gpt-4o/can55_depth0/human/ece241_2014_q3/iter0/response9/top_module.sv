module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign the values based on the given K-map
    assign mux_in[0] = (c == 1'b0 && d == 1'b0) ? 1'b0 :
                       (c == 1'b0 && d == 1'b1) ? 1'b1 :
                       (c == 1'b1 && d == 1'b0) ? 1'b1 :
                       (c == 1'b1 && d == 1'b1) ? 1'b1 : 1'b0;

    assign mux_in[1] = (c == 1'b0 && d == 1'b0) ? 1'b0 :
                       (c == 1'b0 && d == 1'b1) ? 1'b0 :
                       (c == 1'b1 && d == 1'b0) ? 1'b0 :
                       (c == 1'b1 && d == 1'b1) ? 1'b0 : 1'b0;

    assign mux_in[2] = (c == 1'b0 && d == 1'b0) ? 1'b0 :
                       (c == 1'b0 && d == 1'b1) ? 1'b0 :
                       (c == 1'b1 && d == 1'b0) ? 1'b0 :
                       (c == 1'b1 && d == 1'b1) ? 1'b1 : 1'b0;
                       
    assign mux_in[3] = (c == 1'b0 && d == 1'b0) ? 1'b1 :
                       (c == 1'b0 && d == 1'b1) ? 1'b0 :
                       (c == 1'b1 && d == 1'b0) ? 1'b1 :
                       (c == 1'b1 && d == 1'b1) ? 1'b1 : 1'b0;

endmodule
