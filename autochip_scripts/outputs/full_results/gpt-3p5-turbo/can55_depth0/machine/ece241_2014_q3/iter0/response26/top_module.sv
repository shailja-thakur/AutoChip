module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

/* Declaration of internal signals */
wire or_gate_output;
wire not_gate_output;
wire and_gate_output;

/* Instantiate gates */
or_gate or1(c, d, or_gate_output);
not_gate not1(d, not_gate_output);
and_gate and1(c, d, and_gate_output);

/* Assignments to mux_in */
assign mux_in[0] = or_gate_output;
assign mux_in[1] = 0;
assign mux_in[2] = ~d;
assign mux_in[3] = and_gate_output;

endmodule
module or_gate (
  input a,
  input b,
  output y
);
  assign y = a | b;
endmodule
module not_gate (
  input a,
  output y
);
  assign y = ~a;
endmodule
module and_gate (
  input a,
  input b,
  output y
);
  assign y = a & b;
endmodule
