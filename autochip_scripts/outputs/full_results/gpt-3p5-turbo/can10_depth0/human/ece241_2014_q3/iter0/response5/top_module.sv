module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Define intermediate wires
wire w0, w1, w2, w3, w4, w5, w6, w7;

// Implement the logic for mux_in using 2-to-1 multiplexers
// Mux for mux_in[0]
assign w0 = ~c & ~d;
assign w1 = ~c & d;
assign w2 = c & ~d;
assign w3 = c & d;
assign mux_in[0] = (w0 & mux_sel[0]) | (w1 & ~mux_sel[0]) | (w2 & mux_sel[0]) | (w3 & ~mux_sel[0]);

// Mux for mux_in[1]
assign w4 = c & ~d;
assign w5 = c & d;
assign w6 = ~c & ~d;
assign w7 = ~c & d;
assign mux_in[1] = (w4 & mux_sel[1]) | (w5 & ~mux_sel[1]) | (w6 & mux_sel[1]) | (w7 & ~mux_sel[1]);

// Mux for mux_in[2]
assign w0 = ~c & ~d;
assign w1 = ~c & d;
assign w2 = ~c & ~d;
assign w3 = c & d;
assign mux_in[2] = (w0 & mux_sel[2]) | (w1 & ~mux_sel[2]) | (w2 & mux_sel[2]) | (w3 & ~mux_sel[2]);

// Mux for mux_in[3]
assign w4 = ~c & d;
assign w5 = c & ~d;
assign w6 = ~c & d;
assign w7 = c & d;
assign mux_in[3] = (w4 & mux_sel[3]) | (w5 & ~mux_sel[3]) | (w6 & mux_sel[3]) | (w7 & ~mux_sel[3]);

endmodule
