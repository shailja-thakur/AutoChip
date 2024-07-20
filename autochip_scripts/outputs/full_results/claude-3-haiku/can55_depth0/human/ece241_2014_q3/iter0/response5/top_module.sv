module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] tmp;

    assign tmp[0] = c & ~d; // cd = 00
    assign tmp[1] = c & d; // cd = 11

    assign mux_in[0] = tmp[0]; // ab = 00
    assign mux_in[1] = c & ~d; // ab = 01
    assign mux_in[2] = tmp[1]; // ab = 11
    assign mux_in[3] = ~c & d; // ab = 10

endmodule
