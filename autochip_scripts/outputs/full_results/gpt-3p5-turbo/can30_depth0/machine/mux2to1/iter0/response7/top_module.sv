module top_module (
    input a,
    input b,
    input sel,
    output out
  );

  // implementation of multiplexer
  always @(*)
  begin
    if (sel == 1'b1) // select b if 'sel' is 1
      out = b;
    else // select a if 'sel' is 0
      out = a;
  end

endmodule
