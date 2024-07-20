module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire ab;

// Implementing the 2-to-1 multiplexers 
assign mux_in[0] = (ab & c & d) | (ab & ~c & d) | (ab & ~c & ~d);
assign mux_in[1] = (~ab & c & ~d) | (ab & c & ~d) | (ab & ~c & ~d);
assign mux_in[2] = (~ab & ~c & ~d) | (ab & ~c & d) | (ab & c & ~d);
assign mux_in[3] = (ab & ~c & ~d) | (~ab & ~c & d) | (~ab & c & ~d) | (~ab & c & d);

// Implementing the 4-to-1 multiplexer
assign ab = mux_in[2] | mux_in[3];

endmodule
