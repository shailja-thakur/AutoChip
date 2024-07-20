module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire c_not = ~c;
    wire d_not = ~d;
    wire cd = c & d;
    wire cd_not = c & d_not;
    wire c_not_d = c_not & d;
    wire c_not_d_not = c_not & d_not;

    assign mux_in[0] = c_not_d_not;
    assign mux_in[1] = cd_not;
    assign mux_in[2] = cd;
    assign mux_in[3] = c_not_d;
endmodule
