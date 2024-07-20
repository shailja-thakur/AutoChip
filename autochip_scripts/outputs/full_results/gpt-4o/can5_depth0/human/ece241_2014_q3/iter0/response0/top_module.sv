module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire not_c = ~c;
    wire not_d = ~d;

    assign mux_in[0] = not_c & not_d;   // K-map: 00  -->  Function F = 0
    assign mux_in[1] = c & not_d;       // K-map: 01  -->  Function F = 1
    assign mux_in[2] = d;               // K-map: 11  -->  Function F = d
    assign mux_in[3] = not_d | c;       // K-map: 10  -->  Function F = 1

endmodule
