module top_module (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);

  reg temp_assign;

  always @(*) begin
    if (sel_b1 && sel_b2)
      temp_assign = b;
    else
      temp_assign = a;
  end

  assign out_assign = temp_assign;

  always @(a, b, sel_b1, sel_b2) begin
    if (sel_b1 && sel_b2)
      out_always = b;
    else
      out_always = a;
  end

endmodule
