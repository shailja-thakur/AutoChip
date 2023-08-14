module top_module ( input clk, input d, output q );

  my_dff dff1 ( .clk(clk), .d(d), .q(q1) );
  my_dff dff2 ( .clk(clk), .d(q1), .q(q2) );
  my_dff dff3 ( .clk(clk), .d(q2), .q(q3) );

endmodule