module top_module (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);

// Assign the value of either input a or input b to out_assign using an assign statement
assign out_assign = (sel_b1 & sel_b2) ? b : a;

// Use an always block to assign the value of either input a or input b to out_always
always @ (a, b, sel_b1, sel_b2)
  if (sel_b1 & sel_b2)
    out_always = b;
  else
    out_always = a;

endmodule
