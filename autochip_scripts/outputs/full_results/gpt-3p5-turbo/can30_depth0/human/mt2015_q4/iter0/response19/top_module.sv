module A (
  input x,
  input y,
  output z
);
  assign z = (x ^ y) & x;
endmodule
module B (
  input x,
  input y,
  output z
);
  reg [2:0] time = 0;
  always @ (negedge time) begin
    case (time)
      0: z = 1;
      5: z = 1;
      10: z = 1;
      15: z = 1;
      20: z = 1;
      25: z = 0;
      30: z = 0;
      35: z = 0;
      40: z = 0;
      45: z = 1;
      50: z = 1;
      55: z = 1;
      60: z = 0;
      65: z = 0;
      70: z = 1;
      75: z = 0;
      80: z = 0;
      85: z = 0;
      90: z = 0;
    endcase
    time = time + 5;
  end
endmodule
module top_module(
  input x,
  input y,
  output z
);
  wire a1_z, b1_z, a2_z, b2_z;
  A a1 (.x(x), .y(y), .z(a1_z));
  B b1 (.x(x), .y(y), .z(b1_z));
  A a2 (.x(x), .y(y), .z(a2_z));
  B b2 (.x(x), .y(y), .z(b2_z));
  or #(2) or_gate (.a(a1_z), .b(b1_z), .z(z));
  and #(2) and_gate (.a(a2_z), .b(b2_z), .z(z));
endmodule
