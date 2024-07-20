module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;

assign a = c & (~d);
assign b = ~c & d;

// Implementing the 4-to-1 mux
assign mux_in[0] = (~a & ~d) | (a & c);
assign mux_in[1] = (a & ~d) | (~a & ~c);
assign mux_in[2] = (a & d) | (~a & ~c);
assign mux_in[3] = (a & d) | (~a & c);

endmodule
