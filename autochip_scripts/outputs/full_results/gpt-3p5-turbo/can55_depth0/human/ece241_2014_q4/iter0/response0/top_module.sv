module top_module (
    input clk,
    input x,
    output z
);

  reg d_ff1, d_ff2, d_ff3;
  wire x_flipflop1,not_x_flipflop1;
  wire not_x_flipflop2;
  wire not_x_flipflop3;
  wire z;

  xor x_flipflop1_xor (x_flipflop1, d_ff1, x);
  and #(2) x_flipflop1_and (not_x_flipflop2, d_ff2, ~x);
  or #(2) x_flipflop1_or (not_x_flipflop3, d_ff3, ~x);

  d_ff d_ff4 (d_ff1, x_flipflop1, clk);
  d_ff d_ff5 (d_ff2, not_x_flipflop2, clk);
  d_ff d_ff6 (d_ff3, not_x_flipflop3, clk);

  xnor xnor_gate (z, x_flipflop1, x_flipflop2, x_flipflop3);

endmodule
module xor (output out, input a, input b);
  assign out = a ^ b;
endmodule
module or (output out, input a, input b);
  assign out = a | b;
endmodule
module and #(parameter WIDTH=1) (output out, input a, input b);
  assign out = a & b;
endmodule
module xnor (output out, input a, input b, input c);
  assign out = ~(a ^ b ^ c);
endmodule
module d_ff (output out, input d, input clk);
  reg q;
  always @(posedge clk) begin
    q <= d;
  end
  assign out = q;
endmodule
