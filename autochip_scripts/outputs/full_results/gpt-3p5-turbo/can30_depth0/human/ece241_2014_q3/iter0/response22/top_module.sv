module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] ab;

// Implementing the 2-to-1 multiplexers
assign mux_in[0] = (ab[1] & ab[0] & ~c & d) | (ab[1] & ab[0] & ~c & ~d) | (ab[1] & ab[0] & c & d) | (ab[1] & ab[0] & c & ~d) | (ab[1] & ~ab[0] & c & d) | (~ab[1] & ab[0] & ~c & d) | (~ab[1] & ~ab[0] & c & ~d);
assign mux_in[1] = ~(ab[1] & ab[0] & ~c) & ~(ab[1] & ~ab[0] & c) & ~(ab[1] & ~ab[0] & ~d) | ~(ab[1] & ab[0] & ~c) & ~(~ab[1] & ab[0] & ~c) & ~(ab[1] & ab[0] & c) & ~(ab[1] & ~ab[0] & ~d) & ~(~ab[1] & ab[0] & d) | ~(ab[1] & ~ab[0] & ~d) & ~(~ab[1] & ab[0] & d) & ~(ab[1] & ab[0] & c) | ~(ab[1] & ab[0]);
assign mux_in[2] = (ab[1] & ab[0] & ~c & d) | (ab[1] & ~ab[0] & ~c & d) | (~ab[1] & ab[0] & c & d) | (ab[1] & ~ab[0] & c & ~d) | (ab[1] & ab[0] & c & d) | (~ab[1] & ab[0] & ~c & ~d) | (~ab[1] & ab[0] & c & ~d);
assign mux_in[3] = ~(ab[1] & ab[0] & ~c & d) & ~(ab[1] & ~ab[0] & c & d) & ~(ab[1] & ab[0] & ~d) | ~(ab[1] & ab[0] & ~c & ~d) & ~(ab[1] & ~ab[0] & c & d) & ~(ab[1] & ab[0] & ~d) | ~(ab[1] & ab[0] & c & ~d) & ~(ab[1] & ~ab[0] & c & d) & ~(ab[1] & ab[0] & ~d) | ~(ab[1] & ab[0] & c & d) & ~(ab[1] & ab[0] & ~c) & ~(ab[1] & ~ab[0] & ~d);

// Implementing the 4-to-1 multiplexer
assign ab[1] = a;
assign ab[0] = b;

endmodule
