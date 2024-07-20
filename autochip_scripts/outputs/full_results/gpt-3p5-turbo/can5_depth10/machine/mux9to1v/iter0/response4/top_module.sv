module top_module (
  input [15:0] a,
  input [15:0] b,
  input [15:0] c,
  input [15:0] d,
  input [15:0] e,
  input [15:0] f,
  input [15:0] g,
  input [15:0] h,
  input [15:0] i,
  input [3:0] sel,
  output [15:0] out
);

  always_comb
    case (sel)
      4'b0000: out = a;  // If sel is 0, the output is assigned to the input a.
      4'b0001: out = b;  // If sel is 1, the output is assigned to the input b.
      4'b0010: out = c;  // If sel is 2, the output is assigned to the input c.
      4'b0011: out = d;  // If sel is 3, the output is assigned to the input d.
      4'b0100: out = e;  // If sel is 4, the output is assigned to the input e.
      4'b0101: out = f;  // If sel is 5, the output is assigned to the input f.
      4'b0110: out = g;  // If sel is 6, the output is assigned to the input g.
      4'b0111: out = h;  // If sel is 7, the output is assigned to the input h.
      4'b1000: out = i;  // If sel is 8, the output is assigned to the input i.
      default: out = 16'b1;  // The default value of the output is '1.
    endcase

endmodule
