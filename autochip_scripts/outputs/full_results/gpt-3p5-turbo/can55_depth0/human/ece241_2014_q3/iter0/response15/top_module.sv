module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
  
  // 2-to-1 multiplexers
  wire w0, w1, w2, w3, w4, w5, w6, w7;
  assign w0 = ~c & ~d;
  assign w1 = c & ~d;
  assign w2 = c & d;
  assign w3 = ~c & d;
  
  // 4-to-1 multiplexer
  wire [3:0] mux_out;
  wire a, b;
  assign a = w0 | w1;
  assign b = w1 | w3;
  assign mux_in[0] = ~a & ~b & mux_out[0];
  assign mux_in[1] = ~a & b & mux_out[1];
  assign mux_in[2] = a & b & mux_out[2];
  assign mux_in[3] = a & ~b & mux_out[3];
  
  // 4-to-1 multiplexer outputs
  mux4x1 mux (
    .x0(w4), .x1(w5), .x2(w6), .x3(w7),
    .s0(a), .s1(b),
    .z(mux_out)
  );
  
endmodule
module mux4x1(x0, x1, x2, x3, s0, s1, z);
input x0, x1, x2, x3, s0, s1;
output z;

wire w1, w2, w3;

and(w1, x0, ~s0, ~s1);
and(w2, x1, s0, ~s1);
and(w3, x2, s0, s1);
and(z, x3, ~s0, s1);

or(z, w1, w2, w3, z);

endmodule
