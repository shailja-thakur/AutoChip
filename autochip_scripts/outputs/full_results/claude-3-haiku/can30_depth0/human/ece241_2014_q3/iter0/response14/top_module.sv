module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux2_out;

    // Implement the Karnaugh map using two-input multiplexers
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = c;
    assign mux_in[2] = d;
    assign mux_in[3] = c & d;

endmodule
