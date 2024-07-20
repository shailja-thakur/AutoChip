module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;

assign a = c & (~d);
assign b = ~c & d;

// Implementing the 4-to-1 mux
assign mux_in[0] = (~a & ~b) | (c & ~d);
assign mux_in[1] = (~a & b) | (c & ~d);
assign mux_in[2] = (a & ~b) | (c & d);
assign mux_in[3] = (a & b) | (~c & d);

endmodule
