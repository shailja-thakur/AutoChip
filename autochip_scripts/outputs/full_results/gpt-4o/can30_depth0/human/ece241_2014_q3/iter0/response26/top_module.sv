module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    assign mux_in[0] = d & ~c;      // 00, value is 1 when d=1 and c=0
    assign mux_in[1] = 0;           // 01, always 0
    assign mux_in[2] = (d & c) | (~d & c);  // 11, value is 1 when d=1 or both d=0 and c=1
    assign mux_in[3] = 1;           // 10, always 1
endmodule
