module top_module (
  input logic a,
  input logic b,
  input logic sel_b1,
  input logic sel_b2,
  output logic out_assign,
  output logic out_always
);

  assign out_assign = (sel_b1 & sel_b2) ? b : a;
  
  always @(a, b, sel_b1, sel_b2)
  begin
    if (sel_b1 & sel_b2)
      out_always = b;
    else
      out_always = a;
  end
  
endmodule
