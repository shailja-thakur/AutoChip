module xor_gate (
    input a,
    input b,
    output y
  );
    assign y = a ^ b;
  endmodule
module and_gate (
    input a,
    input b,
    output y
  );
    assign y = a & b;
  endmodule
module or_gate (
    input a,
    input b,
    output y
  );
    assign y = a | b;
  endmodule
module xnor_gate (
    input a,
    input b,
    input c,
    output y
  );
    assign y = ~(a ^ b) ^ c;
  endmodule
module d_flip_flop (
    input clk,
    input d,
    output reg q
  );
    always @(posedge clk)
      q <= d;
  endmodule
